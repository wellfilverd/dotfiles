" Vim Plug
call plug#begin('~/.vim/plugged')

call plug#begin()
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-fireplace'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'kovisoft/paredit', { 'for': 'clojure' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'aklt/plantuml-syntax'
  Plug 'tyru/open-browser.vim'
  Plug 'weirongxu/plantuml-previewer.vim'
call plug#end()

:let mapleader = ","

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
" Disable auto comment in the next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" tabulation
:set tabstop=2 shiftwidth=2 softtabstop=2 expandtab list!

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

" visual settings
set mouse=nv
set mousemodel=popup_setpos
set cursorline
set scrolloff=5

" Swap Files
set backupdir=$TMPDIR//
set directory=$TMPDIR//
set undodir=$TMPDIR//

" Copy/Past clipboard macro
map <C-c> "*yy
"map <C-v> "*p

" CocVim

" Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Symbol operations
" Rename Symbol
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Formatting selected buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"PlantUML
au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),1,0)
