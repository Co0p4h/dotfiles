set number
syntax on
set tabstop=4
set shiftwidth=4
set relativenumber
set expandtab
set smartindent
set ignorecase
set mouse=a
set title
set hlsearch
set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/undodir
set undofile
set incsearch
set scrolloff=6

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'folke/tokyonight.nvim'
Plug 'morhetz/gruvbox'
call plug#end()

let mapleader = " " " set leader key to space
" map <leader>h :noh<CR>
map <leader>l $
map <leader>h _
map <leader>j 10j
map <leader>k 10k
" map <A-BS> <C-w>

" colorscheme tokyonight
colorscheme gruvbox
