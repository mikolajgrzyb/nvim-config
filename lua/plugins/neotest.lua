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
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run Last Test",
    },
    {
      "<leader>tw",
      "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch --' })<cr>",
      desc = "Run Watch",
    },
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Jest Test",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run Jest for Current File",
    },

    {
      "<leader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop Jest for Current Test",
    },
  },
}
