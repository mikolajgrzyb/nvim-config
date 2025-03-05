return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find marks" },
    { '<leader>f"', "<cmd>Telescope registers<cr>", desc = "Find registers" },
  },
}
