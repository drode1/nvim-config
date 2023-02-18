set mouse=a
set encoding=utf-8
set number
set relativenumber
set noswapfile
set scrolloff=7
syntax on
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

inoremap jk <esc> # ESC

autocmd FileType python set colorcolumn=79

" отключаем клавиши стрелок
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


call plug#begin('~/.vim/plugged')

" color scheme
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
" telescope finder and telescope grep
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } 
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } 
" lua plugin for telescope
Plug 'nvim-lua/plenary.nvim' 
call plug#end()


colorscheme OceanicNext


" Netrw file explorer settings
let g:netrw_banner = 0 " hide banner above files
let g:netrw_liststyle = 3 " tree instead of plain view
let g:netrw_browse_split = 3 " vertical split window when Enter pressed on file

" отключаем выделение
nnoremap ,<space> :nohlsearch<CR> 

" Prettier

" Telescope bindings
" поиск телескопа
nnoremap ,f <cmd>Telescope find_files<cr> 
" поиск телескопа для грепп
noremap ,g <cmd>Telescope live_grep<cr> 

" Telescope fzf plugin
lua << EOF
require('telescope').load_extension('fzf')
EOF



