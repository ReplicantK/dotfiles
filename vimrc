" REMINDER: reflect changes into init.lua

" globals
let g:is_posix = 1

" general quality of life sets
set mouse=""
set number
set showmode
set colorcolumn=80
set incsearch
set hlsearch
set termguicolors
set ignorecase
set autoindent
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set expandtab
set guicursor=""
set timeout
set ttimeout
set timeoutlen=3000
" only used when using LSP diagnostics
"set signcolumn=yes
set ttimeoutlen=10
set path=.,,**
set wildmenu
set statusline=%F\ %h%m%r%=%-14(%l,%c%V%)\ %P
set laststatus=2

" misc cmds, annoying indentation etc
filetype indent off
filetype plugin off
autocmd FileType make setlocal noexpandtab

" theme and visual cmds
syntax on
colorscheme base16-tokyo-city-mod
highlight clear TODO
highlight link TODO Comment

" key remaps
nnoremap j gj
nnoremap k gk
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap [b bprev<cr>
nnoremap ]b bnext<cr>
