return {
  -- Plugins LSP + Mason
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      { "neovim/nvim-lspconfig" }, -- Required
      {
        "williamboman/mason.nvim",
        build = function()
          vim.cmd("MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Integração do Mason com lspconfig

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
      { "rafamadriz/friendly-snippets" }, -- Snippets pré-configurados
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local lsp = require("lsp-zero")

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        local keymap = vim.keymap.set
        local buf = vim.lsp.buf
        local diagnostic = vim.diagnostic

        keymap("n", "gr", buf.references, vim.tbl_extend("force", opts, { desc = "LSP Goto Reference" }))
        keymap("n", "gd", buf.definition, vim.tbl_extend("force", opts, { desc = "LSP Goto Definition" }))
        keymap("n", "K", buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
        keymap("n", "<leader>vws", buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "LSP Workspace Symbol" }))
        keymap("n", "<leader>vd", diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "LSP Show Diagnostics" }))
        keymap("n", "[d", diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
        keymap("n", "]d", diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
        keymap("n", "<leader>vca", buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP Code Action" }))
        keymap("n", "<leader>vrn", buf.rename, vim.tbl_extend("force", opts, { desc = "LSP Rename" }))
        keymap("i", "<C-h>", buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP Signature Help" }))
      end

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
	  "marksman",
	  "jsonls",
	  "pylsp",
	  "dockerls",
	  "bashls",
          "gopls",
        },
        handlers = {
          lsp.default_setup,
          -- Configuração específica para Language Servers:
          lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      lsp.setup({
        on_attach = on_attach,
      })
    end,
  }
}
