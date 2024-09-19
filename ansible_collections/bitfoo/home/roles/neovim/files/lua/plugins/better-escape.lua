-- Creates a map where all elements from list are
-- initialized with value true, that makes it possible
-- to search if element is in list
local function Set(list)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set
end

return {
  "max397574/better-escape.nvim",
  opts = {
    timeout = vim.o.timeoutlen,
    mappings = {
      t = {
        j = {
          k = function()
            -- Blacklist of commands where jk is not a
            -- mapping to return to normal mode
            local blacklist_cmds = Set({ "lazygit" })
            local t = require("toggleterm.terminal")
            -- Get the command from the current focused Terminal
            local term_cmd = t.get(t.get_focused_id(), true).cmd
            if blacklist_cmds[term_cmd] then
              return false
            end
            return "<C-\\><C-n>"
          end,
        },
      },
    },
  },
}
