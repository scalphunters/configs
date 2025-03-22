syntax on
set number
set cursorline
set cursorcolumn
set expandtab
set shiftwidth=2
set tabstop=2
set nobackup
set showmatch
set hlsearch
set history=1000
set noswapfile
set ai
filetype plugin on
set mouse=a
set relativenumber
set foldmethod=manual "indent
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
