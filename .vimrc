" Vim Plug
call plug#begin('~/.vim/plugged')

call plug#begin()
  Plug 'preservim/nerdtree'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'clojure-vim/async-clj-omni'
call plug#end()

" Nerd Tree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Mouse Support
set mouse=a

" Syntax Configuration
" enable syntax
syntax on
:set backspace=indent,eol,start
:set formatoptions-=cro

" tabulation
:set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab

" default to relative line numbers
set number
set numberwidth=5
set signcolumn=number

" highlight current cursor line
set cul

" scroll settings
set scrolloff=999
set sidescrolloff=999

" colorschema
colorscheme carbonized-dark
let g:carbonized_dark_CursorLineNr = 'off'
let g:carbonized_light_CursorLineNr = 'off'
let g:carbonized_dark_LineNr = 'off'
let g:carbonized_light_LineNr = 'off'

" Copy/Past clipboard macro
map <C-c> "*yy
"map <C-v> "*p

