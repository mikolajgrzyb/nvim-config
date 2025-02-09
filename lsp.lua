return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      angularls = {
        cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
        filetypes = { "typescript", "html", "angular" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("angular.json", "package.json", "tsconfig.json")(fname)
        end,
      },
    },
  },
}
