syntax enable
let mapleader = "\<Space>"

filetype plugin on
filetype indent on

set history=500

set nocompatible
filetype off

set rtp+=$HOME/.vim_config/plugins/Vundle.vim
call vundle#begin('$HOME/.vim_config/plugins')

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'mileszs/ack.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'preservim/nerdtree'
Plugin 'airblade/vim-rooter'
Plugin 'rhysd/vim-clang-format'
Plugin 'dense-analysis/ale'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'chriskempson/base16-vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

call vundle#end()
filetype plugin indent on

" Line over and under the cursor
set so=10

" Set relative line numbers
set number relativenumber
set nu rnu

" Fixes cursor lag
set ttimeoutlen=100

" Show search count (only works in vim 8.0+)
set shortmess-=S

" Show command while typing
set showcmd

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

let base16colorspace=256

" Searching better
set ignorecase
set smartcase
set hlsearch
set incsearch 

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Allow mouse clicks
set mouse=a

" Config backspace to behave normally
set backspace=indent,eol,start

" Set internal encoding of vim
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" TextEdit might fail if hidden is not set.
set hidden

set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Add a bit extra margin to the left
set foldcolumn=1

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" clipboard shortcut
noremap <leader>y "+y
noremap <leader>p "+p

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Toggle between two buffers
map <silent> <leader><leader> <c-^>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>

" Map auto complete of (, ", ', [
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CursorShape for TMUX with iTerm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $TERM_PROGRAM =~ "iTerm"
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    endif
endif