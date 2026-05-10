-- TODO: update treesitter to the new incompatible rewrite
require("nvim-treesitter.configs").setup({
  highlight = {enable = true, additional_vim_regex_highlighting = false},

  auto_install = true,

  ensure_installed = {
    "cpp",
    "java",
    "javascript",
    "python",
    "c",
    "html",
    "css",
    "dockerfile",
    "bash",
    "markdown",
    "lua",
    "vimdoc",
    "sql",
  }
})

vim.keymap.set("n", "<leader>t", require("nvim-treesitter.install").update())
