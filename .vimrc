syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nocompatible
set hidden
set encoding=utf-8
set showtabline=0
set background=dark

set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#ff0000 ctermbg=234
set bs=2
set wrap linebreak nolist

" Plugins
call plug#begin('~/.vim/plugged')
" Nerd tree for file browser
Plug 'preservim/nerdtree'

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline-themes'
Plug 'leafgarland/typescript-vim'
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git'
Plug 'git@github.com:ycm-core/YouCompleteMe.git'
Plug 'git@github.com:ackyshake/VimCompletesMe.git'
Plug 'git@github.com:Vimjas/vim-python-pep8-indent.git'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'

" Silver Searcher
Plug 'mileszs/ack.vim'


" End of Plugins
call plug#end()

" Custom function for delete trailing spaces
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//e
  exe "normal `z"
endfunc

set modelines=1
let mapleader = " "

if executable('ag')
  let g:ackprg = 'ag --vimgrep'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endi

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:airline_theme='badwolf'
let g:fzf_layout = { 'down': '~40%' }

" Quick fixes for ale
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': [],
      \'python': ['black', 'isort'],
      \'typescript': ['prettier'],
      \'javascript':['prettier']}
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>


" FZF Config Settings
command! -bang ProjectFiles call fzf#vim#files('~/Dev', <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Nerd tree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" You completer
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gs :YcmCompleter GoToSymbol<CR>

" Remapped keys for navigating windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>s :wincmd s<CR>
nnoremap <leader>q :wincmd q<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>-5 :vertical resize -5<CR>
nnoremap <leader>1 :only<CR>
nnoremap <Leader>b :ls<CR>:b<Space>


" Git shortcuts
nnoremap <leader>gs :G<CR>

" Delete trailing spaces
nnoremap <leader>w :call DeleteTrailingWS()<CR>
autocmd BufWritePre * :%s/\s\+$//e
