return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
  },
  opts = function(_, opts)
    opts.adapters = {
      require("neotest-jest")({
        jestCommand = function()
          -- Auto-detect NX project and run the correct Jest command
          local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- Get current project folder name
          return "npx nx test " .. project .. " --"
        end,
        jestConfigFile = function()
          -- Support both `jest.config.ts` and `jest.config.js`
          local config_ts = vim.fn.getcwd() .. "/jest.config.ts"
          local config_js = vim.fn.getcwd() .. "/jest.config.js"
          if vim.fn.filereadable(config_ts) == 1 then
            return config_ts
          elseif vim.fn.filereadable(config_js) == 1 then
            return config_js
          else
            return nil
          end
        end,
        env = { CI = "true" }, -- Prevent Jest from running interactively
        cwd = function()
          return vim.fn.getcwd() -- Ensure tests run in the correct NX project
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
      desc = "Run Jest Test Under Cursor",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run Jest for Current File",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open()
      end,
      desc = "Show Test Output",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Test Summary",
    },
  },
}
