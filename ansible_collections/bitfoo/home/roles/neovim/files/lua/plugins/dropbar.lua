return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope-fzf-native.nvim" },
    init = function()
      vim.o.mousemoveevent = true -- Used for hover in dropbar on mouseover
    end,
    opts = {},
  },
}
