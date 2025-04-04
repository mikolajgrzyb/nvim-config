local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "projekt0n/github-nvim-theme",
      name = "github-theme",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
    },
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- add LazyVim and import its plugins
    { import = "lazyvim.plugins.extras.lang.json" },

    { "echasnovski/mini.nvim", version = "*" },
    { import = "lazyvim.plugins.extras.lang.angular" },

    { import = "lazyvim.plugins.extras.lang.go" },

    { import = "lazyvim.plugins.extras.lang.php" },

    { import = "lazyvim.plugins.extras.lang.docker" },

    { import = "lazyvim.plugins.extras.lang.astro" },

    { import = "lazyvim.plugins.extras.lang.sql" },

    { import = "lazyvim.plugins.extras.lang.python" },

    { import = "lazyvim.plugins.extras.linting.eslint" },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

    {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
    },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "InsertEnter",
    --   opts = {
    --     -- cfg options
    --   },
    -- },

    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
