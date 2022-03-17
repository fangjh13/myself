let mapleader = ","

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set termencoding=utf-8
set encoding=utf-8
set number
set relativenumber
set hlsearch
hi Search ctermbg=LightYellow ctermfg=Red
set incsearch
set ruler
set showmode
set history=1000
set backspace=indent,eol,start
set wildignorecase
set ignorecase
set smartcase
set autowrite
set autoread

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
set wildmode=longest:full,full
set wildoptions=pum

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

    " trigger autoread when changing buffers inside while inside vim
    autocmd FocusGained,BufEnter * :checktime

    " fzf temporarily disable the statusline for a cleaner look.
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
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
" MacVim use Menlo for Powerline font please install it first
" set guifont=Menlo\ for\ Powerline


" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Declare the list of plugins.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" popup window make fzf open in a tmux popup window (requires tmux 3.2 or above)
" See `man fzf-tmux` for available options
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
endif

