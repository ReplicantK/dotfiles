set ruler
set number
set hlsearch
set backspace=indent,eol,start
set ignorecase
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
syntax on
colorscheme peachpuff
hi Search ctermfg=88 ctermbg=214
hi Comment ctermfg=gray ctermbg=NONE
hi clear TODO
hi link TODO Comment
inoremap jk <Esc>
autocmd FileType make setlocal noexpandtab
