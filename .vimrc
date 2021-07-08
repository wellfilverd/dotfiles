" default to relative line numbers
set number
set numberwidth=5
set signcolumn=number
set relativenumber

" Highlight current cursor line
set cul
hi CursorLine term=underline cterm=underline ctermbg=none

" Default indent style
set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab

:nmap nl o<Esc><CR>
:nmap NL O<Esc><CR>

set scrolloff=999
set sidescrolloff=999
