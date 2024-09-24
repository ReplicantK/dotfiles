-- lazy package manager
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

require("lazy").setup({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "sevenwhiteclouds/breezy",
  "nvim-treesitter/nvim-treesitter",
  {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}}
})

-- treesitter
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

-- REMINDER: reflect changes into .vimrc
local g = vim.g
local set = vim.opt
local cmd = vim.cmd
local map = vim.keymap.set

-- globals
g.is_posix = 1

-- general quality of life sets
set.mouse = ""
set.number = true
set.showmode = true
set.colorcolumn = "80"
set.incsearch = true
set.hlsearch = true
set.termguicolors = true
set.ignorecase = true
set.autoindent = true
set.backspace = "indent,eol,start"
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.guicursor = ""
set.timeout = true
set.ttimeout = true
set.timeoutlen = 3000
set.ttimeoutlen = 10
set.signcolumn = "yes:1"
set.path = ".,,**"
set.wildmenu = true
set.statusline = "%F %h%m%r%=%-14(%l,%c%V%) %P"
set.laststatus = 3

-- misc cmds, annoying indentation etc
cmd.filetype("indent off")
cmd.filetype("plugin off")
cmd.autocmd("FileType make setlocal noexpandtab")

-- theme and visual cmds
cmd.syntax("on")
require("breezy").setup({color_set = "breezy"})
cmd.colorscheme("breezy")
cmd.highlight("clear TODO")
cmd.highlight("link TODO Comment")

-- key remaps for scrolling, buffer cycle, etc
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "[b", "<cmd>bprev<cr>")
map("n", "]b", "<cmd>bnext<cr>")
map("n", "tf", "<cmd>Telescope find_files<cr>")
map("n", "tg", "<cmd>Telescope live_grep<cr>")
map("n", "tb", "<cmd>Telescope buffers<cr>")

-- TODO: match all lsp shortcuts with intellij/vscode
-- lsp
-- these work without an lsp
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

-- these only work if there is an active language server
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = {buffer = event.buf}

    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  end
})

require("mason").setup({})
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

  handlers = {
    function(server)
      require("lspconfig")[server].setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  },
})

local cmp = require("cmp")

cmp.setup({
  -- to disable autocomplete
  --completion = {
  --  autocomplete = false
  --},

  sources = cmp.config.sources({
    {name = "nvim_lsp"},
  }), 

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
})
