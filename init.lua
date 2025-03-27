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

vim.keymap.set({ "n" }, "<C-k>", function()
  require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

vim.keymap.set({ "n" }, "<Leader>k", function()
  vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

local function filterDuplicates(array)
  local uniqueArray = {}
  for _, tableA in ipairs(array) do
    local isDuplicate = false
    for _, tableB in ipairs(uniqueArray) do
      if vim.deep_equal(tableA, tableB) then
        isDuplicate = true
        break
      end
    end
    if not isDuplicate then
      table.insert(uniqueArray, tableA)
    end
  end
  return uniqueArray
end

local function on_list(options)
  options.items = filterDuplicates(options.items)
  vim.fn.setqflist({}, " ", options)
  vim.cmd("botright copen")
end

vim.lsp.buf.references(nil, { on_list = on_list })
