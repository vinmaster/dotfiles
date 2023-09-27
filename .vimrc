"filetype off

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/AutoTag'
Plug 'pangloss/vim-javascript'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'vim-ruby/vim-ruby'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'flazz/vim-colorschemes'
Plug 'easymotion/vim-easymotion'
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json'
Plug 'mbbill/undotree'
call plug#end()

"filetype plugin indent on

set background=dark   " enable for dark terminals
set tabstop=2         " number of spaces a tab counts for
set shiftwidth=2      " spaces for autoindents
set expandtab         " turn a tabs into spaces
set smartindent       " smart auto indent
set smarttab          " smart tab handling for indenting
set hlsearch          " highlight search results
set incsearch         " show search matches as you type
set ignorecase        " case insensitive search
set number            " show line numbers
set list              " show hidden characters
" set listchars=eol:$,tab:->,trail:~,extends:>,precedes:< " define list characters
" set listchars=tab:->,trail:~,extends:>,precedes:< " define list characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set backspace=indent,eol,start " fix backspace problems
set ruler             " show cursor position in status bar
set cursorline        " show a horizontal line where the cursor is
set mouse=nchv        " use mouse in all mode (normal,insert,command,help,visual mode)
set showtabline=2     " always show tab bar
set scrolloff=1       " Always show at least one line above/below the cursor
set showcmd
set cmdheight=1
set ttyfast
set ttymouse=xterm2
set pastetoggle=<F2>  " make pasting behave with smart indent
set noswapfile
set nobackup
set autoread
set nocompatible
set clipboard=unnamed " use system clipboard
map <F3> :s/^/#
map <F4> I#<Esc><Esc>
nnoremap J gT " Goto next tab
nnoremap K gt " Goto previous tab
nnoremap <Leader>j :bn<CR> " Goto next buffer
nnoremap <Leader>k :bp<CR> " Goto previous buffer
nnoremap <Leader><Leader> <c-^> " Goto to last buffer opened
"nnoremap <C-J> <C-W><C-W>
nnoremap <C-J> <C-W><Down> " Goto pane downwards
nnoremap <C-K> <C-W><Up>
nnoremap <C-H> <C-W><Left>
nnoremap <C-L> <C-W><Right>

"colorscheme default
colorscheme hybrid
syntax on

" Run command in bg
command! -nargs=1 Silent
  \ | execute ':silent !'.<q-args>
  \ | execute ':redraw!'
cmap w!! w !sudo tee > /dev/null % " Allow saving when vim starts without sudo
let mapleader=" "
let g:NERDTreeDirArrows=0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
set laststatus=2

" Switch buffers
nmap <C-e> :CtrlPBuffer<CR>
" Switch to last buffer
nmap <C-e><C-e> :e#<CR>
" Move cursor by display line when wrapping
nmap j gj
nmap k gk
" Clear search
nmap \q :nohlsearch<CR>
" Keep text selected when indenting
vnoremap < <gv
vnoremap > >gv

" Commenting blocks of code. C-_ maps to C-/
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>
autocmd FileType c,cpp,java,js    let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '

" suround word
vnoremap <Leader>" c""<Esc>P
nnoremap <Leader>d" di"hPl2x
vnoremap <Leader>' c''<Esc>P
nnoremap <Leader>d' di'hPl2x
vnoremap <Leader>( c()<Esc>P
nnoremap <Leader>d( di(hPl2x
vnoremap <Leader>{ c{}<Esc>P
nnoremap <Leader>d{ di{hPl2x
map <leader>d "_d
map <leader>y "*y
map <cr> :w\|!./%<cr>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

