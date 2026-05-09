-- bootstrap and append lazy to the neovim environment
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- initialize and configure lazy
local lazy = require("lazy")
lazy.setup({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  {"L3MON4D3/LuaSnip",version = "v2.*"},
  {"nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = {"nvim-lua/plenary.nvim"}
  },
  "CreaturePhil/vim-handmade-hero"
})

vim.keymap.set("n", "<leader>l", lazy.show)
