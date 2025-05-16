let g:is_posix = 1
let g:mapleader = " "

set background=dark
set mouse=
set number
set showmode
set colorcolumn=80
set incsearch
set hlsearch
set termguicolors
set ignorecase
set autoindent
set backspace=
set tabstop=2
set report=0
set shiftwidth=2
set expandtab
set guicursor=
set timeout
set ttimeout
set timeoutlen=3000
set ttimeoutlen=10
" only used when using LSP diagnostics
"set signcolumn=yes
set path=.,,**
set wildmenu
set statusline=%F\ %h%m%r%=%-14(%l,%c%V%)\ %P
set laststatus=2
set updatetime=1300
set showcmd
filetype indent off
filetype plugin off
autocmd FileType make setlocal noexpandtab
syntax on
colorscheme habamax
highlight clear TODO
highlight link TODO Comment

nnoremap [b :bprev<cr>
nnoremap ]b :bnext<cr>
nnoremap j gj
nnoremap k gk
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
