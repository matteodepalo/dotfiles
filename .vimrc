" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'

call plug#end()
" }}}

let mapleader=','

" General settings {{{
set encoding=utf-8
set t_Co=256                      " moar colors
set clipboard=unnamed             " use system clipboard
set nocompatible                  " nocompatible is good for humans
syntax enable                     " enable syntax highlighting...
filetype plugin indent on         " depending on filetypes...
set timeout tm=1000 ttm=100       " fix slight delay after pressing Esc then O
set autoread                      " auto load files if vim detects change
set autowrite                     " auto write files when moving around
set nobackup                      " disable backup files...
set noswapfile                    " and swap files

" Style
set background=dark
color gruvbox
set number                        " line numbers are cool
set relativenumber                " relative numbers are cooler
set ruler                         " show the cursor position all the time
set nocursorline                  " disable cursor line
set showcmd                       " display incomplete commands
set novisualbell                  " no flashes please
set scrolloff=3                   " provide some context when editing
set hidden                        " Allow backgrounding buffers without writing them, and
                                  " remember marks/undo for backgrounded buffers

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
set ttymouse=xterm2

" Searching
set hlsearch                      " highlight matches...
nohlsearch                        " but don't highlight last search when reloading
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless they contain at least one capital letter

" Windows
set splitright                    " create new horizontal split on the right
set splitbelow                    " create new vertical split below the current window

" Folding
set foldmethod=syntax
set nofoldenable
" }}}

" easy global search
nnoremap <C-S> :Ack <C-R><C-W><CR>
vnoremap <C-S> y<Esc>:Ack '<C-R>"'<CR>

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" plugin mappings
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>a <Esc>:Ack<space>
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>F :CtrlPClearCache<CR>\|:CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>t :wa<CR>\|:TestFile<CR>
nnoremap <leader>T :wa<CR>\|:TestNearest<CR>

" open quickfix when running tests
autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)

" easier navigation between split windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" disable cursor keys in normal mode
nnoremap <Left>  :echo "no!"<CR>
nnoremap <Right> :echo "no!"<CR>
nnoremap <Up>    :echo "no!"<CR>
nnoremap <Down>  :echo "no!"<CR>

" easy way to switch between latest files
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>vs :execute "vsplit " . bufname("#")<CR>
nnoremap <Leader>sp :execute "split " . bufname("#")<CR>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" remove whitespaces and windows EOL
command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>
nnoremap <Leader>kw :KillWhitespace<CR>
nnoremap <Leader>kcm :KillControlM<CR>

" remove trailing spaces
function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()

" copy current path
nnoremap <silent> <Leader>p :let @* = expand("%")<CR>

" expand %% to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <Leader>e :e %%

" delete current file
nnoremap <Leader>rm :call delete(expand('%')) \| bdelete!<CR>

" toggle a fold with Space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Y u no consistent?
function! YRRunAfterMaps()
  nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
endfunction

" plugin confirguration
let g:ctrlp_match_window = 'bottom,order:btt,min:5,max:5,results:5'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMouseMode = 3
let g:ackhighlight = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:test#preserve_screen = 1
let g:yankring_history_dir = '$HOME/.vim'
let test#ruby#minitest#file_pattern = 'test_.*\.rb' " the default is '_test\.rb'
let test#strategy = "vimux"

" FileType settings {{{
if has("autocmd")
  " enable <CR> in command line window and quickfix
  augroup enable_cr
    au!
    au CmdwinEnter * nnoremap <buffer> <CR> <CR>
    au BufWinEnter quickfix nnoremap <buffer> <CR> <CR>
  augroup END

  " treat JSON files like JavaScript
  augroup filetype_json
    au!
    au BufNewFile,BufRead *.json setf javascript
  augroup END

  " remember last location in file, but not for commit messages,
  " or when the position is invalid or inside an event handler,
  " or when the mark is in the first line, that is the default
  " position when opening a file. See :help last-position-jump
  augroup last_position
    au!
    au BufReadPost *
      \ if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
endif
" }}}
