" If there's a vimrc inside current dir, read it
set exrc

" Gets rid of that pesky highlighting on searched terms
set nohlsearch

" If you don't save a file then the buffer persists
set hidden

set noerrorbells
set nowrap

" Make searching match case intelligently
set ignorecase
set smartcase

" Shows the number of the current line, alongside the  relative
" number of lines before and after, to make navigation easier.
set number relativenumber

" Indentation settings
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set noswapfile
set nobackup

" Visual indicator of 80 characters
set colorcolumn=80

" Shows things like LSP warnings or git integration
set signcolumn=yes

set termguicolors

" Progressively highlighting search terms whilst typing
set incsearch

" Scroll a lil faster by jumping at the 8th line from the top or bottom
" Depending on context
set scrolloff=8

" this will install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin()

    " this is for auto complete, prettier and tslinting
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

    " These are for autocomplete
    Plug 'nvim-lua/completion-nvim'
    Plug 'aca/completion-tabnine', { 'do': './install.sh' }
    Plug 'honza/vim-snippets'

    " Coc extensions for Typesript, css, html, json, js and Rust.
    let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-rust-analyzer']

    "this will auto close ( [ {
    Plug 'jiangmiao/auto-pairs'

    " These plugins add highlighting and indenting to JSX and TSX files.
    Plug 'yuezk/vim-js'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'maxmellon/vim-jsx-pretty'

    " File viewer.
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'

    " Gruvbox colour scheme.
    Plug 'gruvbox-community/gruvbox'

    " To get the purrty icons
    Plug 'ryanoasis/vim-devicons'

    " Highlight hex colour codes
    Plug 'norcalli/nvim-colorizer.lua'

    " HTML Emmet plugin, allows for fast HTML tags.
    Plug 'mattn/emmet-vim'


    call plug#end()


colorscheme gruvbox


let mapleader = " "

" Runs a global grep for a given string
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>

" Opens file browser
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>

" Calls the autocomplete whenever something enters the buffer
autocmd BufEnter * lua require'completion'.on_attach()

" This turns on the Hexadecimal colour highlighting for every file
autocmd BufEnter * lua require'colorizer'.setup()


" This function runs a global regex on the current file and if there's any
" pesky whitespace trailing any lines then it's removed. nice.
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" This autogroup calls the TrimWhitespace function upon writing a file.
augroup NOT_THE_LEWIS
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
