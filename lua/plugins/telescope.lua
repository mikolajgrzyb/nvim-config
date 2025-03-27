return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find marks" },
    { '<leader>f"', "<cmd>Telescope registers<cr>", desc = "Find registers" },
  },
  opts = {
    defaults = {
      path_display = { "smart" },
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          width = { padding = 0 },
          height = { padding = 0 },
          preview_width = 0.5,
        },
      },
      borders = {},
    },
  },
}
