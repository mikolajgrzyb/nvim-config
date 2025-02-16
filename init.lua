-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.cmd.colorscheme("retrobox")
    vim.api.nvim_create_user_command("SetCursorGreen", function()
      vim.cmd("highlight Cursor guifg=#000000 guibg=#00FF00")
    end, {})

    vim.defer_fn(function()
      vim.cmd("highlight Cursor guifg=#000000 guibg=#00FF00")
    end, 100)
  end,
})

local namu = require("namu.namu_symbols")
local colorscheme = require("namu.colorscheme")
vim.keymap.set("n", "<leader>ss", namu.show, {
  desc = "Jump to LSP symbol",
  silent = true,
})
vim.keymap.set("n", "<leader>th", colorscheme.show, {
  desc = "Colorscheme Picker",
  silent = true,
})
