call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

call plug#end()

" Additional leader keys

nmap , \
vmap , \

nmap <space> \
vmap <space> \

" Map tab key to next buffer
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>

" map `=` and `-`  to end and beginning of line
nnoremap = $
nnoremap - 0

" Map l key to right pane and h key to left pane
map <C-L> <C-w>w
map <C-H> <C-w>p

set number

set cursorline
set ignorecase
set showmatch

filetype plugin indent on " Automatically detect file types.
syntax on  " syntax highlighting
set mouse=a " enable mouse mode

set noerrorbells visualbell t_vb=    " Disable all bells
set autoindent                       " remember indent after going to the next line
set showcmd                          " show command that is being entered in the lower right
set backspace=indent,eol,start       " Allow extended backspace behaviour
set virtualedit=block                " allow placing the cursor after the last char

" Use 2-space soft tabs by defaults
" (it's overriden for some some languages with different conventions).
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Remember cursor position when re-opening a file
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "normal! g`\"" |
  \ endif

" Set folding to leader-L
" zr to unfold and zm to fold. zR to unfold all and zM to fold all
nmap <Leader>l :set foldmethod=syntax<CR>

" Remap jj to escape insert mode
inoremap jj <ESC>

" Map leader-S to save file
nmap <Leader>s :w<CR>

" Map leader-q to quit vim
nmap <Leader>q :qa!<CR>

" vim-airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Show buffer number in status bar
let g:airline#extensions#tabline#buffer_nr_show = 1

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" do no jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" NERDTree
" Shortcut to open/close
map <Leader>n :NERDTreeToggle<CR>
" Highlight the current buffer (think of 'find')
map <Leader>f :NERDTreeFind<CR>

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1 " show hidden files at startup
let NERDTreeIgnore = ['\.pyc$', '\.class$'] " http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeAutoDeleteBuffer=1 " automatically replace/close the corresponding buffer when a file is moved/deleted

" CtrlP
let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|\.hg|\.svn|\.bundle|bin|bbin|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|class|pyc)$',
  \ }

" use ctrlp in a single shortcut to navigate buffers
noremap <Leader>b :CtrlPBuffer<CR>

" use ag (https://robots.thoughtbot.com/faster-grepping-in-vim), 
" because faster and respects .gitignore
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Search and replace current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Remap leader-d to delete buffer
nmap <Leader>d :bd

" Remap gc comments to leader-c
nmap <Leader>c gcc
vmap <Leader>c gc

" Remove excess whitespace
set listchars=tab:»·,trail:·,extends:>,precedes:<
nmap <silent> <leader>w :set nolist!<CR>

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c)
endfun

autocmd FileType Dockerfile,make,c,coffee,cpp,css,eruby,eelixir,elixir,html,java,javascript,json,markdown,php,puppet,python,ruby,scss,sh,sql,text,typescript,vim,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Allow enter to chose from the omnicompletion window, instead of <C-y>
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set pastetoggle=<F3>

set wildignore+=*.swp,*/tmp/
set noswapfile
set noundofile
