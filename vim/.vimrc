set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set termencoding=utf-8
set encoding=utf-8
set number
set relativenumber
set hlsearch
set incsearch
set ruler
set showmode
set history=1000
set backspace=indent,eol,start

" map Ctrl+p as Up Ctrl+n as Down
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" map buffer
nnoremap <silent> [b :bprevious <CR>
nnoremap <silent> ]b :bnext <CR>
nnoremap <silent> [B :bfirst <CR>
nnoremap <silent> ]B :blast <CR>

syntax on

" wildmode as zsh
set wildmenu
set wildmode=full

" map %% expand current direcotry
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

" ctrl-a and ctrl-x use decimal only
set nrformats=

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    
    " config yaml indent
    autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

" Mac OS X clipboard sharing
" set clipboard=unnamed
