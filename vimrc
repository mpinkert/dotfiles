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
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

" Version control integration
Plugin 'mhinz/vim-signify'
let g:signify_sign_change ='*'

call vundle#end()
filetype plugin indent on


" Incorporate all files in vimrc.d
for f in split(glob($DOTFILES . '/vimrc.d/*.vim'), '\n')
    exe 'source' f
endfor

" Options

"Update time for vim signify"
set updatetime=100

"
" Hit '%' on 'if' to jump to 'else'
runtime macros/matchit.vim

" Colorschemes
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
        let $t_Co = 256
    colorscheme molokai_git
else
    colorscheme delek
endif

if &term =~ '256color'
    " Disable background color erase so that color schemes work properly
    " when Vim is used inside tmux and GNU screen
    set t_ut=
endif

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

" Interface changes
set showcmd
set vb "Do not beep on errors

set scrolloff=3 " When scrolling, keep cursor 3 lines away from screen border
" -- Highlighting --
set cursorline
syntax on   

" Highlight EOL spaces
highlight WhiteSpaceEOL ctermbg=lightgreen
match WhiteSpaceEOL /\s\+$/

" Highlight leading tab/space mixtures
highlight LeadingTabSpaceMix ctermbg=lightgreen
match LeadingTabSpaceMix /^\s*\(\t \)\|\( \t\)\s*/
