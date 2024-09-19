return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
    init = function()
      -- Toggle terminal
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "[t]oggle [t]erminal" })

      --  See `:help window-resize` for a list of all window commands
      vim.keymap.set("t", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
      vim.keymap.set("t", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
      vim.keymap.set("t", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
      vim.keymap.set("t", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

      --  See `:help windows-resize` for a list of all window commands
      vim.keymap.set("t", "<M-h>", "3<C-w><", { silent = false, desc = "Move focus to the left window" })
      vim.keymap.set("t", "<M-l>", "3<C-w>>", { silent = false, desc = "Move focus to the right window" })
      vim.keymap.set("t", "<M-k>", "3<C-w>+", { silent = false, desc = "Move focus to the lower window" })
      vim.keymap.set("t", "<M-j>", "3<C-w>-", { silent = false, desc = "Move focus to the upper window" })

      -- Require Terminal class from toggleterm
      local Terminal = require("toggleterm.terminal").Terminal

      -- Create a terminal and execute lazygit in it
      local lazygit_term = Terminal:new({
        cmd = "lazygit",
        display_name = "lazygit",
        direction = "float",
        close_on_exit = true,
        hidden = true,
        float_opts = {
          border = "double",
          title_pos = "center",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function()
          vim.cmd("startinsert!")
        end,
      })
      -- Keymap to open lazygit
      vim.keymap.set("n", "<leader>tg", function()
        lazygit_term:toggle()
      end, { desc = "Toggle lazy[g]it in terminal" })
    end,
  },
}
