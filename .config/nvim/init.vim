"     ____ ____  _____         _          
"    / ___|  _ \|  ___| __ ___(_)_ __ ___ 
"   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
"   | |_| |  _ <|  _|| | |  __/ | | |  __/     https://grfreire.com
"    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
"                                         

set guifont=Cascadia\ Code\ 11

:set number
:set relativenumber
:set autoindent
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set clipboard=unnamedplus

call plug#begin()

Plug 'romgrk/doom-one.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

set encoding=UTF-8

call plug#end()

set background=dark
:colorscheme doom-one

let g:airline_theme='deus'
let g:airline_symbols_ascii = 1

autocmd BufEnter * lcd %:p:h
nnoremap <C-b> :NERDTreeToggle<CR>

let g:NERDTreeGitStatusUseNerdFonts = 1

" --- Just Some Notes ---
" :PlugClean :PlugInstall
" -----------------------

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
