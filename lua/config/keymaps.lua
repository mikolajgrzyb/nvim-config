-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

-- delete single char without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", vim.tbl_extend("force", opts, { desc = "Replace word under the cursor" }))

-- press jk fast to exit insert mode
-- vim.keymap.set("i", "jk", "<ESC>", opts)
-- vim.keymap.set("i", "kj", "<ESC>", opts)

-- buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)

-- resize windows
vim.keymap.set("n", "S-<Up>", ":resize +10<CR>", opts)
vim.keymap.set("n", "S-<Down>", ":resize -10<CR>", opts)
vim.keymap.set("n", "<S-Left>", ":vertical resize +10<CR>", opts)
vim.keymap.set("n", "<S-Right>", ":vertical resize -10<CR>", opts)

-- commenting
vim.keymap.set("n", "gcd", "yygccp", { remap = true, silent = true, desc = "Duplicate line and comment out the first" })

vim.keymap.set("n", "<C-x>", function()
  local current_file = vim.fn.expand("%:r") -- Get file name without extension
  local file_ext = vim.fn.expand("%:e") -- Get current file extension

  -- Define the extension swap table
  local extension_map = {
    ts = "html",
    html = "scss",
    scss = "ts",
  }

  -- Find new extension or default to `.txt` if not mapped
  local new_ext = extension_map[file_ext] or "txt"
  local new_file = current_file .. "." .. new_ext

  local file_exists = vim.fn.filereadable(new_file) == 1
  if not file_exists then
    print("File does not exist: " .. new_file)
    return
  end
  -- Open the new file
  vim.cmd("e " .. new_file)
  vim.cmd("bd #")
end, opts)

vim.keymap.set("n", "<leader>yp", function()
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1] -- Get Git root
  local path = vim.fn.expand("%:p") -- Full file path
  local rel_path = string.gsub(path, root .. "/", "") -- Strip root path
  vim.fn.setreg("+", rel_path) -- Copy to clipboard
  print("Copied: " .. rel_path) -- Show message
end, { silent = true, noremap = true, desc = "copy current file path" })

local builtin = require("telescope.builtin")
local design = {
  path_display = { "smart" },
  sorting_strategy = "ascending",
  borders = {},
  borderchars = { "", "", "", "", "", "", "", "" },
  layout_config = {
    horizontal = {
      prompt_position = "top",
      width = { padding = 0 },
      height = { padding = 0 },
      preview_width = 0.5,
    },
  },
}
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files(vim.tbl_deep_extend("force", {}, design))
end, { desc = "Find Files (custom layout)" })

vim.keymap.set("n", "<leader><space>", function()
  builtin.find_files(vim.tbl_deep_extend("force", {}, design))
end, { desc = "Find Files (custom layout)" })

vim.keymap.set("n", "<leader>fF", function()
  builtin.find_files(vim.tbl_deep_extend("force", {
    cwd = require("lazyvim.util").root(),
  }, design))
end, { desc = "Find Files (Root Dir)" })

-- 🔍 Live Grep from current working directory
vim.keymap.set("n", "<leader>sg", function()
  builtin.live_grep(vim.tbl_deep_extend("force", {}, design))
end, { desc = "Live Grep (custom layout)" })

-- 🔍 Live Grep from root directory
vim.keymap.set("n", "<leader>sG", function()
  builtin.live_grep(vim.tbl_deep_extend("force", {
    cwd = require("lazyvim.util").root(),
  }, design))
end, { desc = "Live Grep (root dir, custom layout)" })

vim.keymap.set("n", "<leader>fe", function()
  require("neo-tree.command").execute({ toggle = true, position = "float" })
end, { desc = "Toggle Neo-tree (float)" })
