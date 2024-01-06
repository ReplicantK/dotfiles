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
set laststatus=2
set noshowmode
let g:is_posix = 1
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
autocmd FileType make setlocal noexpandtab
"set colorcolumn=80

syntax on
colorscheme base16-tokyo-city-mod
hi clear TODO
hi link TODO Comment
let g:lightline = {
  \'colorscheme': 'base16_tokyo_city_lightline_mod',
  \}
