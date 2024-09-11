return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
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
      -- Create toggleterm keymap with better control
      vim.keymap.set("n", "<leader>\\", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
      --
      -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      -- is not what someone will guess without a bit more experience.
      -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      -- or just use <C-\><C-n> to exit terminal mode
      vim.keymap.set("t", "<Esc><Esc>", "<cmd>ToggleTerm<CR>", { desc = "Exit terminal mode" })
      vim.keymap.set("t", "jkjk", "<cmd>ToggleTerm<CR>", { desc = "Exit terminal mode" })
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
          vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "i",
            "<ESC><ESC>",
            "<cmd>ToggleTerm<cmd>",
            { noremap = true, silent = true }
          )
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
