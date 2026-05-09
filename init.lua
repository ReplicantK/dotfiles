-- REMINDER: always reflect comparable settings into .vimrc

vim.g.mapleader = " "

require("opts")
require("keymaps")
require("lazy")
require("cmds")
require("telescope")
require("mason")
require("lspconfig")
require("autocmp")
