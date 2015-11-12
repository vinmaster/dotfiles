filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/AutoTag'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nathanaelkane/vim-indent-guides'
call vundle#end()
filetype plugin indent on

"set background=dark   " enable for dark terminals
set tabstop=2         " number of spaces a tab counts for
set shiftwidth=2      " spaces for autoindents
set expandtab         " turn a tabs into spaces
set smartindent       " smart auto indent
set smarttab          " smart tab handling for indenting
set hlsearch          " highlight search results
set incsearch         " show search matches as you type
set ignorecase        " case insensitive search
set number            " show line numbers
set ruler             " show cursor position in status bar
set cursorline        " show a horizontal line where the cursor is
set mouse=v           " use mouse in visual mode (not normal,insert,command,help mode
set pastetoggle=<F2>  " make pasting behave with smart indent
set nobackup
set noswapfile
set autoread
set nocompatible
map <F3> :s/^/#
map <F4> I#<Esc><Esc>
nnoremap J gT
nnoremap K gt
colorscheme default
syntax on
cmap w!! w !sudo tee > /dev/null % " Allow saving when vim starts without sudo
let mapleader=" "
let g:NERDTreeDirArrows=0
set laststatus=2

