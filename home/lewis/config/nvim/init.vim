set number relativenumber

call plug#begin()
Plug 'nvim-lua/completion-nvim'
Plug 'aca/completion-tabnine', { 'do': './install.sh' }
Plug 'honza/vim-snippets'
call plug#end()
autocmd BufEnter * lua require'completion'.on_attach()