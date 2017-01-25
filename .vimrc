" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wincent/Command-T'

call plug#end()
" }}}

" General settings {{{
set encoding=utf-8
set t_Co=256                      " moar colors
set clipboard=unnamed             " use system clipboard
set nocompatible                  " nocompatible is good for humans
syntax enable                     " enable syntax highlighting...
filetype plugin indent on         " depending on filetypes...
set autoread                      " auto load files if vim detects change
set autowrite                     " auto write files when moving around
set nobackup                      " disable backup files...
set noswapfile                    " and swap files

" Style
set background=dark
set number                        " line numbers are cool
set relativenumber                " relative numbers are cooler
set ruler                         " show the cursor position all the time
set nocursorline                  " disable cursor line
set showcmd                       " display incomplete commands
set novisualbell                  " no flashes please
set scrolloff=3                   " provide some context when editing

" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set softtabstop=2                 " when deleting, treat spaces as tabs
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " keep indentation level when no indent is found

" Mouse
set mousehide                     " hide mouse when writing
set mouse=a                       " we love the mouse

" Searching
set hlsearch                      " highlight matches...
nohlsearch                        " but don't highlight last search when reloading
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless they contain at least one capital letter
" }}}

" easy global search
nnoremap <C-S> :Ack <C-R><C-W><CR>
vnoremap <C-S> y<Esc>:Ack '<C-R>"'<CR>
" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>a <Esc>:Ack<space>
nnoremap <Leader>f :CommandT<CR>
nnoremap <Leader>F :CommandTFlush<CR>\|:CommandT<CR>
nnoremap <Leader>. :CommandTTag<CR>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" easier navigation between split windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

let g:ackhighlight = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:CommandTCancelMap = ['<Esc>', '<C-C>']
let g:CommandTFileScanner = 'git'
let g:CommandTMaxHeight = 20
let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<Esc>OB']
let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<Esc>OA']
let g:CommandTTraverseSCM = 'pwd'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMouseMode = 3
