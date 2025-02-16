return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      angularls = {
        -- cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
        filetypes = { "typescript", "html", "angular" },
        root_dir = function(fname)
          local root = require("lspconfig.util").root_pattern(
            "angular.json",
            "workspace.json",
            "nx.json",
            "package.json",
            "tsconfig.base.json"
          )(fname)

          if root then
            -- 🚀 Include `libs/` for Go to Definition (`gd`)
            vim.lsp.buf.execute_command({
              command = "_typescript.applyWorkspaceEdit",
              arguments = {
                {
                  changes = {
                    [root .. "/libs"] = {},
                  },
                },
              },
            })
          end

          return root
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
    },
  },
}
