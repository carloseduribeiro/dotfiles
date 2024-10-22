return {
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- Atualiza os pacotes instalados
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls" },
        automatic_installation = false,
      })
    end
  },
}
