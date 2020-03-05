set nocompatible
filetype off

let vundleInstalled=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let vundleInstalled=0
endif

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
if vundleInstalled == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

filetype off

" -- Vim Plugins -- "

" Indent guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" File browser in Vim
Plugin 'scrooloose/nerdtree'

" Code commenter
Plugin 'scrooloose/nerdcommenter'

" Language code checker
Plugin 'vim-syntastic/syntastic'

"Colormaps
Plugin 'tomasr/molokai'

" Version control integration
Plugin 'mhinz/vim-signify'


call vundle#end()
filetype plugin indent on

" Options

" Hit '%' on 'if' to jump to 'else'
runtime macros/matchit.vim

" Colorschemes
colorscheme molokai

" Screen splitting behavior
set splitbelow
set splitright

set backspace=indent,eol,start " Make backspace work as expected
set incsearch hlsearch "Search incrementally and highlight results in progress
set ruler " set line, col at the bottom of the window

" Set tabs to be 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set nu

set vb "Do not beep on errors
