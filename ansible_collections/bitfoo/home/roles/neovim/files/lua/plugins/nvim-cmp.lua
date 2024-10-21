return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      "dmitmel/cmp-digraphs",
      "f3fora/cmp-spell",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      cmp.setup({
        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Set the menu array to strings visible by completion
            local menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              cmdline = "[Cmd]",
              calc = "[Calc]",
              digraphs = "[Digraphs]",
              spell = "[Spell]",
            }
            -- initialise kind with lspkind and manipulate it afterwards
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
            })(entry, vim_item)
            -- Split the kind string into two parts
            -- first is the icon second the type of completion
            local strings = vim.split(kind.kind, "%s", { trimempty = true })

            -- Add the icon
            kind.kind = " " .. (strings[1] or "") .. " "
            -- Add the type and source of completion as in menu
            -- Display entry.source.name??? if there is nothing in menu{}
            kind.menu = "   (" .. (strings[2] or "") .. ") " .. (menu[entry.source.name] or entry.source.name .. "???")
            return kind
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext or [p]revious item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          -- Generally you don't need this, because nvim-cmp will display
          -- completions whenever it has completion options available.
          ["<C- >"] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 990 },
          { name = "nvim_lsp_signature_help", priority = 980 },
          {
            name = "buffer",
            priority = 970,
            option = {
              -- Only show completion from buffers visible in current window
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "luasnip", priority = 960 },
          {
            name = "digraphs",
            priority = 955,
            option = {
              filter = function(item)
                local allowed_charnr = {
                  0x00C4, -- Ä
                  0x00E4, -- ä
                  0x00D6, -- Ö
                  0x00F6, -- ö
                  0x00DC, -- Ü
                  0x00FC, -- ü
                  0x00DF, -- ß
                  0x20AC, -- €
                }
                for _, value in ipairs(allowed_charnr) do
                  if item.charnr == value then
                    return true
                  end
                end
                return false
              end,
            },
          },
          { name = "spell", priority = 953 },
          { name = "path", priority = 950 },
          { name = "calc" },
        }),
      })
    end,
  },
}
