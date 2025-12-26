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
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" OSC 52를 통한 클립보드 복사
set clipboard=unnamedplus

function! Osc52Yank()
    let buffer=system('base64 -w0', @0)
    let buffer=substitute(buffer, "\n$", "", "")
    let buffer='\e]52;c;'.buffer.'\x07'
    silent exe "!echo -ne ".shellescape(buffer)." > /dev/tty"
endfunction

" + 레지스터로 yank할 때 자동으로 OSC52 실행
autocmd TextYankPost * if v:event.operator ==# 'y' && (v:event.regname ==# '+' || v:event.regname ==# '') | call Osc52Yank() | endif

