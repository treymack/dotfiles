let mapleader = ","

" Fast saving
nmap <leader>w :wa!<cr>

" Insert to Normal mode real quick-like
inoremap jk <Esc>
inoremap kj <Esc>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" insert date with F3
nmap <F3> i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>
nmap <Leader><F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <Leader><F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

syntax enable

" folding
set foldlevelstart=99
set foldmethod=indent
nnoremap <Space> za
vnoremap <Space> za

set number

" editing / sourcing _vimrc
nnoremap <Leader>ve :vsplit $MYVIMRC<cr>
nnoremap <Leader>vs :so $MYVIMRC<cr>

