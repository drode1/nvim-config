set mouse=a
set encoding=utf-8
set number
set relativenumber
set noswapfile
set scrolloff=10
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

autocmd FileType python set colorcolumn=79

" отключаем клавиши стрелок
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


call plug#begin('~/.vim/plugged')

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" color scheme
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext

" telescope finder and telescope grep
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } 
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } 

" lua plugin for telescope
Plug 'nvim-lua/plenary.nvim' 
Plug 'jose-elias-alvarez/null-ls.nvim'

" :MasonUpdate updates registry contents
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
call plug#end()


colorscheme OceanicNext


" Netrw file explorer settings
let g:netrw_banner = 0 " hide banner above files
let g:netrw_liststyle = 3 " tree instead of plain view
let g:netrw_browse_split = 3 " vertical split window when Enter pressed on file

" отключаем выделение
nnoremap ,<space> :nohlsearch<CR> 


" Telescope bindings поиск телескопа
nnoremap ,f <cmd>Telescope find_files<cr> 
" поиск телескопа для грепп
noremap ,g <cmd>Telescope live_grep<cr> 

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end
}

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
vim.lsp.buf.format({ timeout_ms = 2000 }) -- 2 seconds

--Telescope fzf plugin
require('telescope').load_extension('fzf')
EOF
