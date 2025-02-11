return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      angularls = {
        -- cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
        filetypes = { "typescript", "html", "angular" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "angular.json",
            "workspace.json",
            "nx.json",
            "package.json",
            "tsconfig.base.json"
          )(fname)
        end,
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            new_root_dir,
            "--ngProbeLocations",
            new_root_dir,
          }
        end,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
      tsserver = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git")(fname)
        end,
        single_file_support = true,
        on_attach = function(client, bufnr)
          -- If we're in an Angular project, prevent tsserver from starting
          if require("lspconfig.util").root_pattern("angular.json")(vim.fn.getcwd()) then
            client.server_capabilities.documentFormattingProvider = false
          end
        end,
      },
    },
  },
}
