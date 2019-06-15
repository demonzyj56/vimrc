" vim configs from scratch
" sensible settings
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim
unlet! c_comment_strings

" First thing first: general settings
set nocompatible
set backspace=eol,start,indent
set fileformats=unix,dos,mac
set autoread
filetype on
filetype plugin on
filetype indent on
syntax enable

" menu
" required by YouCompleteMe
set encoding=utf8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set hid
set ruler
set laststatus=2
set cmdheight=2
set number
set relativenumber
set so=7
set wildmenu
set history=500
set showmatch
set mat=2
set background=dark
set noshowmode

" editing settings

" tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" turn off all backups
set nobackup
set noswapfile

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set showmatch

" indent
set autoindent
set smartindent
set wrap
set linebreak
set textwidth=500

" off the bell
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

" timeoutlen
set ttimeout
set ttimeoutlen=80

" enable 256 color
set t_Co=256
" Experimental
if has('nvim')
    set termguicolors
endif

" Suppress marco. I don't use it.
nnoremap q :echom "Marco is suppressed"<cr>
