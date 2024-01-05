set termguicolors
set ruler
set number
set incsearch
set hlsearch
set backspace=indent,eol,start
set ignorecase
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
syntax on
colorscheme base16-tokyo-city-mod
set laststatus=2
set noshowmode

let g:lightline = {
  \'colorscheme': 'base16_tokyo_city_lightline_mod', 
  \ }

let g:is_posix = 1
hi clear TODO
hi link TODO Comment
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
autocmd FileType make setlocal noexpandtab
