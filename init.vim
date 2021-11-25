packadd minpac " http://vimcasts.org/episodes/minpac/
call minpac#init()

" Add minpac so it cak update itself
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Color scheme
call minpac#add('romainl/Apprentice')
"'srcery-colors/srcery-vim'

call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

" Javascript
call minpac#add('mxw/vim-jsx')
call minpac#add('pangloss/vim-javascript')

" HTML
call minpac#add('mattn/emmet-vim')

" Undo
call minpac#add('sjl/gundo.vim')
nnoremap <F4> :GundoToggle<CR>

" Code completion
call minpac#add('Shougo/deoplete.nvim')
let g:deoplete#enable_at_startup = 1
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

call minpac#add('tbodt/deoplete-tabnine', {'do': {-> system('./install.sh')}})
call minpac#add('Shougo/neco-vim')

call minpac#add('neomake/neomake')

  " https://www.smoothterminal.com/articles/neovim-for-elixir
  " https://bitboxer.de/2016/11/13/vim-for-elixir/
  " Run Neomake when I save any buffer
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END
  " Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []

   " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  let g:neomake_elixir_enabled_makers = ['mycredo']
  function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
      let l:type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'W'  " Warnings
      let l:type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'C'  " Convention violation
      let l:type = 'W'
    else
      let l:type = 'M'           " Everything else is a message
    endif
    let a:entry.type = l:type
  endfunction

  let g:neomake_elixir_mycredo_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }

call minpac#add('c-brenn/phoenix.vim')
call minpac#add('tpope/vim-projectionist') " required for some navigation features

call minpac#add('slashmili/alchemist.vim')
let g:alchemist_tag_disable = 1

call minpac#add('sheerun/vim-polyglot')

" call minpac#add('ludovicchabant/vim-gutentags')
" let g:gutentags_cache_dir = '~/.tags_cache'

" Ruby and Rails
call minpac#add('tpope/vim-rails')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('tpope/vim-cucumber')
call minpac#add('tpope/vim-dotenv')

call minpac#add('tpope/vim-commentary')

call minpac#add('tpope/vim-haml')

call minpac#add('tpope/vim-surround')

" Git
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')

" Database manipulation
call minpac#add('tpope/vim-dadbod')

" Unix integration
call minpac#add('tpope/vim-eunuch')

" Handy bracket mappings
call minpac#add('tpope/vim-unimpaired')

call minpac#add('scrooloose/nerdTree')
nmap <F3> :NERDTreeToggle<CR>

" Movement
call minpac#add('easymotion/vim-easymotion')

" Fuzzy finder
call minpac#add('junegunn/fzf.vim')

call minpac#add('godlygeek/tabular')

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

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

