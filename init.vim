packadd minpac " http://vimcasts.org/episodes/minpac/
call minpac#init()
" Color scheme
call minpac#add('romainl/Apprentice')
"'srcery-colors/srcery-vim'

" Javascript
call minpac#add('mxw/vim-jsx')
call minpac#add('pangloss/vim-javascript')

" HTML
call minpac#add('mattn/emmet-vim')

" Code completion
call minpac#add('Shougo/deoplete.nvim')
let g:deoplete#enable_at_startup = 1
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Commands and shortcuts
  " Plugin management
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()

  " File management
  nnoremap <C-p> :<C-u>FZF<CR>

" UI
colorscheme apprentice
set background=dark
set termguicolors
set cursorline

set number relativenumber

" Clear highlight
nnoremap <CR> :noh<CR><CR>

" Easy clipboard copying
noremap Y "+y

" Indentation
set breakindent                                      "Mantain indent on wrapping lines
set autoindent                                       "autoindent
set tabstop=2 shiftwidth=2 expandtab softtabstop=2   "tabs = 2 spaces

" Backup
set nowritebackup
set noswapfile
set nobackup
