return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  opts = function(_, opts)
    opts.adapters = {
      require("neotest-jest")({
        jestCommand = "npx jest --",
        jestConfigFile = "jest.config.js", -- Ensure Jest config is loaded
        env = { CI = "true" }, -- Prevent Jest from running interactively
        cwd = function(path)
          return vim.fn.getcwd() -- Ensure tests run in the project root
        end,
      }),
    }
  end,
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Jest Test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run Jest for Current File",
    },
  },
}
