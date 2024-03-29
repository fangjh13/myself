let mapleader = ","
let maplocalleader = "\\"

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Declare the list of plugins.

" Navigation
Plug 'junegunn/fzf'                                " Fuzzy file searching
Plug 'junegunn/fzf.vim'                            " Asynchronous file/tags searcher
Plug 'preservim/nerdtree'                          " Tree explorer

" Go
Plug 'fatih/vim-go'

" Beautify
Plug 'morhetz/gruvbox'                              " gruvbox colorscheme
Plug 'fatih/molokai'                                " molokai colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }             " dracula colorscheme
Plug 'arcticicestudio/nord-vim'                     " nord colorscheme
Plug 'ryanoasis/vim-devicons'                       " For file icons in lots of plugins
Plug 'itchyny/lightline.vim'                        " Lightweight statusline without slow plugin integrations

" Edit
Plug 'AndrewRadev/splitjoin.vim'                    " split and join code
Plug 'machakann/vim-sandwich'                       " pair management
Plug 'tpope/vim-commentary'                         " comment
Plug 'ojroques/vim-oscyank', {'branch': 'main'}     " copy text through SSH
if has('macunix')
    Plug 'lyokha/vim-xkbswitch'                     " automatic keyboard layout switching in insert mode (chinese pinyin friendly use mac) 
endif

" Git
Plug 'airblade/vim-gitgutter'                       " shows git diff markers in the sign column and stages/previews/undoes hunks 
Plug 'tpope/vim-fugitive'                           " Git plugin with commands 'G<command>'

" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Nodejs extension host for neovim, load extensions like VSCode and host language servers

" DAP Debugging Application
Plug 'puremourning/vimspector'                      " vimspector multi-language debugging system for Vim

" Custom Wildmenu
Plug 'romgrk/fzy-lua-native'                        " Luajit FFI bindings to FZY for wilder.nvim
function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
endfunction
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }   " adventurous wildmenu

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


set nocompatible            " disable compatibility to old-time vi
set autowrite               " autowrite when modified
set hidden                  " allow jump to anywhere
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set mouse=a                 " enable mouse click
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum
set wildignorecase
" set cc=80                  " set an 80 column border for good coding style
syntax on                   " syntax highlighting
" set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
" Use filetype detection and file-based automatic indenting.
filetype plugin indent on
" get Lua syntax highlighting inside .vim files 
let g:vimsyn_embed = 'l'

" map %% expand current direcotry
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'
" map Ctrl+p as Up Ctrl+n as Down
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
" map buffer
nnoremap <silent> [b :bprevious <CR>
nnoremap <silent> ]b :bnext <CR>
nnoremap <silent> [B :bfirst <CR>
nnoremap <silent> ]B :blast <CR>
" map tabs
nnoremap <silent> [t :tabprevious <CR>
nnoremap <silent> ]t :tabnext <CR>
nnoremap <silent> [T :tabfirst <CR>
nnoremap <silent> ]T :tablast <CR>
" map quickfix list
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>
nnoremap <leader>cc :cclose<CR>
" map location list
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <leader>lc :lclose<CR>
" highlighting current line and set mark `l`
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
" map alt-backspace to delete the previous word in insert mode
noremap! <A-bs> <C-w>
noremap! <C-h> <C-w>
" map ctrl-a <Home> in insert mode in sert mode and Ex mode
noremap! <C-a> <Home>
" map alt-b alt-w move one word in insert mode and Ex mode
noremap! <A-b> <C-Left>
noremap! <A-f> <C-Right>
noremap! <C-b> <Left>
noremap! <C-f> <Right>
" trigger autoread when changing buffers inside while inside vim
autocmd FocusGained,BufEnter * :checktime
" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" open file in a text by placing text and gf
nnoremap gf :vert winc f<cr>
" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>
" open termnial in insert mode and enter termnial save file
augroup TermExtra
  autocmd!
  autocmd BufEnter term://* start!
  autocmd TermEnter * wall
augroup end
" open terminal in bottom
nmap t<Enter> :bo sp term://zsh\|resize 5<CR>
" ESC enter normal mode when in terminal
tnoremap <Esc> <C-\><C-n>
" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Setting the 'cursorline' and 'cursorcolumn' in the current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  au WinLeave * setlocal nocursorline nocursorcolumn
augroup END
" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
" python3 provider 
let g:python3_host_prog = '~/.pyenv/versions/py310/bin/python'
" use fcitx5-remote auto switching input method
if executable('fcitx5-remote')
    autocmd InsertLeave * :silent !fcitx5-remote -c
    autocmd BufCreate *  :silent !fcitx5-remote -c
    autocmd BufEnter *  :silent !fcitx5-remote -c
    autocmd BufLeave *  :silent !fcitx5-remote -c
endif
" mac use vim-xkbswitch enable
if has('macunix')
    let g:XkbSwitchEnabled = 1
    autocmd BufEnter * let b:XkbSwitchILayout = 'us'
endif

" -------------------------------------------------------------------------------------------------
" Colors settings
" -------------------------------------------------------------------------------------------------

syntax enable

" Use 256 colors in gui_running mode
if !has('gui_running')
  set t_Co=256
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Custom highlighting
"
" hi CurrentWord guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XXX cterm=underline,bold,italic
"                     └┴┴┴┴┴──┐     └┴┴┴┴┤     └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤         └┴┤         └┴┤       └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤
"  gui-vim font color hex code│          │   gui-vim special styles│           │           │ console-vim special styles│
"  ───────────────────────────┘          │   ──────────────────────┘           │           │ ──────────────────────────┘
"       gui-vim background color hex code│     console-vim font term color code│           │
"       ─────────────────────────────────┘     ────────────────────────────────┘           │
"                                                    console-vim background term color code│
" Update colorscheme settings
function! ColorsUpdate()
  try
    if g:colors_name =~# 'gruvbox'
      " Do not use separate background color in sign column
      let g:gitgutter_override_sign_column_highlight = 1
      highlight SignColumn guibg=bg ctermbg=bg
    elseif g:colors_name =~# 'molokai'
      let g:molokai_original = 1
      let g:rehash256 = 1
    else
      let g:rehash256 = 1
    endif

    if exists('g:loaded_lightline')
      let g:lightline.colorscheme = g:colors_name
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
      return
    endif
  catch
      echo "Caught error: " . v:exception
  endtry
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call ColorsUpdate()
augroup END

colorscheme gruvbox
set background=dark

" -------------------------------------------------------------------------------------------------
" NERDTree settings
" -------------------------------------------------------------------------------------------------
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" Show hidden files
let NERDTreeShowHidden=1      
" Toggle side window
map <leader>zz :NERDTreeToggle<CR> 
" map NERDTreeFind
map <leader>nf :NERDTreeFind<CR>


" -------------------------------------------------------------------------------------------------
" lightline.vim settings
" -------------------------------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'branch'] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v%<'
      \ },
      \ 'component_function': {
      \   'branch': 'FugitiveHead'
      \ },
      \ }


" bottom `-- INSERT --` is unnecessary
set noshowmode



" -------------------------------------------------------------------------------------------------
" vim-gitgutter settings
" -------------------------------------------------------------------------------------------------
"
" Use fontawesome icons as signs 
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk)  " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)   " git undo (chunk)


" -------------------------------------------------------------------------------------------------
" go-vim settings
" -------------------------------------------------------------------------------------------------

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" Navigation commands
autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" set .go file a sigle tab as 4 spaces
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4


" Auto formatting and importing
let g:go_fmt_autosave = 0
" converting use camel case
let g:go_addtags_transform = "camelcase"
" use godef fast than guru
let g:go_def_mode = 'godef'
" Use new vim 8.2 popup windows for Go Doc
let g:go_doc_popup_window = 1
" Go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" auto show :GoInfo
let g:go_auto_type_info = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
" let g:go_def_mapping_enabled = 0
" disable vim-go :GoDoc 
let g:go_doc_keywordprg_enabled = 0
" run test in a new terminal 
let g:go_term_enabled = 0

" -------------------------------------------------------------------------------------------------
" wilder.nvim settings
" -------------------------------------------------------------------------------------------------

call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
      \       'dir_command': ['fd', '-td'],
      \       'filters': ['fuzzy_filter'],
      \     }),
      \     wilder#substitute_pipeline({
      \       'pipeline': wilder#python_search_pipeline({
      \         'skip_cmdtype_check': 1,
      \         'pattern': wilder#python_fuzzy_pattern({
      \           'start_at_boundary': 0,
      \         }),
      \       }),
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
      \     }),
      \     [
      \       wilder#check({_, x -> empty(x)}),
      \       wilder#history(),
      \     ],
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern({
      \         'start_at_boundary': 0,
      \       }),
      \     }),
      \   ),
      \ ])

let s:highlighters = [
      \ wilder#pcre2_highlighter(),
      \ has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
      \ ]

let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'border': 'rounded',
      \ 'highlighter': [
      \   wilder#lua_pcre2_highlighter(),
      \   wilder#lua_fzy_highlighter(),
      \ ],
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#56FA7B'}]),
      \ }, 
      \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \ 'left': [
      \   ' ',
      \   wilder#popupmenu_devicons(),
      \   wilder#popupmenu_buffer_flags({
      \     'flags': ' a + ',
      \     'icons': {'+': '', 'a': '', 'h': ''},
      \   }),
      \ ],
      \ 'right': [
      \   ' ',
      \   wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

let s:wildmenu_renderer = wilder#wildmenu_renderer({
      \ 'highlighter': s:highlighters,
      \ 'highlights': {
      \   'accent': wilder#make_hl('MyHighlight', [
                    \ {},
                    \ {},
                    \ {'bold': 1, 'foreground': '#000', 'background': '#56FA7B'},
                    \ ]),
      \ }, 
      \ 'separator': ' · ',
      \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right': [' ', wilder#wildmenu_index()],
      \ })

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': s:popupmenu_renderer,
      \ '/': s:wildmenu_renderer,
      \ 'substitute': s:wildmenu_renderer,
      \ }))


" -------------------------------------------------------------------------------------------------
" fzf settings
" -------------------------------------------------------------------------------------------------

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


" -------------------------------------------------------------------------------------------------
" vim-sandwich settings
" -------------------------------------------------------------------------------------------------
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" adjust indent automatically
let g:sandwich#recipes += [
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['add'],
      \     'linewise'    : 1,
      \     'command'     : ["'[+1,']-1normal! >>"],
      \   },
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['delete'],
      \     'linewise'    : 1,
      \     'command'     : ["'[,']normal! <<"],
      \   }
      \ ]

" starts insert mode after surrounding by parentheses
let g:sandwich#recipes += [
  \   {
  \     'buns': ['(', ')'],
  \     'cursor': 'head',
  \     'command': ['startinsert'],
  \     'kind': ['add', 'replace'],
  \     'action': ['add'],
  \     'input': ['f']
  \   },
  \ ]

" -------------------------------------------------------------------------------------------------
" vimspector debuger settings
" -------------------------------------------------------------------------------------------------
let g:vimspector_enable_mappings = 'HUMAN'
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval


" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gz <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-yank open yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" coc-pairs ignore
autocmd FileType go let b:coc_pairs_disabled = ['<']
" coc-highlight highlight current symbol
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc install extensions
let g:coc_global_extensions = [
      \'coc-markdownlint',
      \'coc-highlight',
      \'coc-go',
      \'coc-json', 
      \'coc-css',
      \'coc-html',
      \'coc-pairs',
      \'coc-protobuf',
      \'coc-pyright',
      \'coc-sh',
      \'coc-spell-checker',
      \'coc-toml',
      \'coc-tsserver',
      \'coc-yaml',
      \'coc-yank',
      \'coc-docker',
      \'coc-sql',
      \]

