-- NOTE: mason and mason-lspconfig are configured as one package in this file
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "jdtls",
    "ts_ls",
    "pyright",
    "bashls",
    "html",
    "cssls",
    "tailwindcss",
    "dockerls",
    "sqlls",
  },
})

vim.keymap.set("n", "<leader>m", require("mason.ui").open)
