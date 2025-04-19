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
  "nvim-treesitter/nvim-treesitter",
  {"L3MON4D3/LuaSnip", version = "v2.3",},
  {"nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = {"nvim-lua/plenary.nvim"}
  },
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

-- TODO: reflect changes into .vimrc
-- globals
vim.g.is_posix = 1

-- general quality of life sets
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.showmode = true
vim.opt.colorcolumn = "80"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 3000
vim.opt.ttimeoutlen = 10
vim.opt.signcolumn = "yes:1"
vim.opt.path = ".,,**"
vim.opt.wildmenu = true
vim.opt.statusline = "%F %h%m%r%=%-14(%l,%c%V%) %P"
vim.opt.laststatus = 3

-- misc cmds, annoying indentation, spammy diagnostics, etc
vim.cmd.filetype("indent off")
vim.cmd.filetype("plugin off")
vim.cmd.autocmd("FileType make setlocal noexpandtab")
vim.diagnostic.enable(false)

-- theme and visual cmds
vim.cmd.syntax("on")
vim.cmd.colorscheme("habamax")
vim.cmd.highlight("clear TODO")
vim.cmd.highlight("link TODO Comment")

-- key remaps for scrolling, buffer cycle, etc
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")

-- TODO: I really need to change these to use a more standard key
-- for my custom layer of key bindings, not just for Telescope.
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")

-- lsp setup
-- TODO: match all lsp shortcuts with intellij/vscode
-- these work without an lsp
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

-- these only work if there is an active language server
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  end
})

-- activate mason and wire up lsp
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

local default = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
  function(server)
    require("lspconfig")[server].setup({capabilities = default})
  end,
})

-- to disable autocomplete: completion = {autocomplete = false}
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"}
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  }),

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})
