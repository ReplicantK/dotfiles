-- REMINDER: always reflect comparable settings into .vimrc

-- set globals
vim.g.is_posix = 1
vim.g.mapleader = " "

-- install lazy package manager and plugings/themes, if not installed, and set
-- keymap
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

local lazy = require("lazy")
lazy.setup({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "nvim-treesitter/nvim-treesitter",
  {"L3MON4D3/LuaSnip",version = "v2.*"},
  {"nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = {"nvim-lua/plenary.nvim"}
  },
  {"webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
  }
})

vim.keymap.set("n", "<leader>l", lazy.show)

-- init treesitter and set keymap
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

-- quality of life opts, theme, general keymaps, and remove annoyances
vim.opt.background = "dark"
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.showmode = true
vim.opt.colorcolumn = "80"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.backspace = ""
vim.opt.tabstop = 2
vim.opt.report = 0
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
vim.cmd.filetype("indent off")
vim.cmd.filetype("plugin off")
vim.cmd.autocmd("FileType make setlocal noexpandtab")
vim.cmd.syntax("on")

require("kanso").setup({
  bold = false,
  italics = false,
  commentStyle = {italic = false},
  keywordStyle = {italic = false},
  undercurl = false,
  background = {dark = "zen"}
})
vim.cmd.colorscheme("kanso")

vim.cmd.highlight("clear TODO")
vim.cmd.highlight("link TODO Comment")
vim.keymap.set("n", "gl", vim.diagnostic.setloclist)
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[b", vim.cmd.bprevious)
vim.keymap.set("n", "]b", vim.cmd.bnext)
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- init telescope and set keymaps
require("telescope").setup({
  defaults = {initial_mode = "normal"},

  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      file_ignore_patterns = {"node_modules/", ".git/", ".venv/", "__pycache__/", ".DS_Store"}
    },

    live_grep = {
      initial_mode = "insert",
      additional_args = {
        "--hidden",
        "--glob", "!node_modules/",
        "--glob", "!.git/",
        "--glob", "!.venv/",
        "--glob", "!__pycache__/",
        "--glob", "!.DS_Store"
      }
    }
  },
})

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep)
vim.keymap.set("n", "<leader>b", telescope_builtin.buffers)

-- init mason and set keymap
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

vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

vim.keymap.set("n", "<leader>m", require("mason.ui").open)

-- make lsp warnings less annoying, remove global default keymaps, and set
-- custom keymaps for lsp
vim.opt.updatetime = 1300
vim.diagnostic.enable(false)

vim.api.nvim_create_autocmd({"CursorHold"}, {
  desc = "Diagnostics on",
  callback = function()
    vim.diagnostic.enable(true)
  end,
})

vim.api.nvim_create_autocmd({"TextChanged", "InsertEnter"}, {
  desc = "Diagnostics off",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local opts = {buffer = args.buf}

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

    -- show a list of all the places where what is under the cursor is used
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- show a list of all implementations of an interface or abstract methods/classes 
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    -- show a list of  symbols (variables, functions, classes, methods, etc.)
    -- in the current file, makes navigation easier
    vim.keymap.set("n", "go", vim.lsp.buf.document_symbol, opts)

    -- go to where type is defined, typically in header files, for example
    vim.keymap.set("n", "gO", vim.lsp.buf.type_definition, opts)

    -- show where a symbol is declared, but not necessarily defined
    -- the difference between int num; and num = 5;
    -- NOTE: many servers do not implement this method, use definition instead
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    -- show where a symbol is defined and not just declared
    -- declared and defined are often in the same location, but not always
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
})

-- init code complete and snippets
-- NOTE: to disable autocomplete set completion = {autocomplete = false}
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
