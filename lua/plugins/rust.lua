return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer" },
    })

    require("rust-tools").setup({
      server = {
        on_attach = function(_, bufnr)
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rr", "<cmd>RustRun<CR>", opts)
          vim.keymap.set("n", "<leader>rt", "<cmd>RustTest<CR>", opts)
        end,
      },
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
