set mouse=a
set encoding=utf-8
set number
set relativenumber
set noswapfile
set scrolloff=7

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
filetype indent on

set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

inoremap jk <esc>

autocmd FileType python set colorcolumn=79


call plug#begin('~/.nvim/plugged')

 color scheme
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext


call plug#end()


colorscheme OceanicNext


" Netrw file explorer settings
let g:netrw_banner = 0 " hide banner above files
let g:netrw_liststyle = 3 " tree instead of plain view
let g:netrw_browse_split = 3 " vertical split window when Enter pressed on file



nnoremap ,<space> :nohlsearch<CR>
