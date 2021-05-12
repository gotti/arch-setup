if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" プラグイン以外のその他設定が続く
" :

filetype plugin indent on
syntax enable
let g:dein#auto_recache = 1
set undodir=$HOME/.config/undodir/
set undofile
let g:undotree_SetFocusWhenToggle = 1

nnoremap <C-u> :UndotreeToggle<CR>
function! g:Undotree_CustomMap()
    map <silent> <buffer> <Esc> q
    map <silent> <buffer> h ?
endfunction

set completeopt=menuone,noinsert,preview

"autoread when the window capture the cursor
set autoread
au FocusGained,BufEnter * :silent! !

set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp
set number
set expandtab
set tabstop=4
set autoindent
set shiftwidth=4
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set hidden
set ignorecase
set hlsearch
set showmatch
set smartcase
set cursorline
set matchtime=1
set matchpairs& matchpairs+=<:>
set clipboard+=unnamedplus
set mouse=a

" for use of autosave and multi window provided by i3, not vim's splitting
set noswapfile
set nobackup

set display=uhex
colorscheme molokai

" disable pasting by middleclick
map <MiddleMouse>   <Nop>
map <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <MiddleMouse>   <Nop>
imap <2-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

"I don't like molokai's hilighting of pair. Is it a bug?
hi MatchParen      ctermfg=208 ctermbg=233 cterm=bold 

tnoremap <ESC> <C-\><C-n>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
"Press ESC twice, nvim disable hilighting of matching
nnoremap <silent> <Esc><Esc> :noh<CR>
"When leaving insertion mode, disable ime
autocmd InsertLeave * call system("fcitx-remote -c")

let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 1

"nmap <silent> <f2> :LspRename<CR>
"let mapleader = ","
"nmap <silent> <Leader>d :LspTypeDefinition<CR>
"nmap <silent> <Leader>r :LspReferences<CR>
"nmap <silent> <Leader>i :LspImplementation<CR>
"let g:lsp_diagnostics_enabled = 1
"let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_text_edit_enabled = 0

" imap <expr> <TAB>
"            \ pumvisible() ? "\<C-n>" :
"            \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"If completion window appears and you press TAB, select next
imap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"
" SuperTab like snippets behavior.
"imap  <expr><TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ neosnippet#expandable_or_jumpable() ?
"    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nmap <silent> <space><space> :<C-u>CocList<cr>
"スペースhでHover
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
"スペースdfでDefinition
nmap <silent> <space>df <Plug>(coc-definition)
"スペースrfでReferences
nmap <silent> <space>rf <Plug>(coc-references)
"スペースrnでRename
nmap <silent> <space>rn <Plug>(coc-rename)
"スペースfmtでFormat
nmap <silent> <space>fmt <Plug>(coc-format)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <f3>  <Plug>(coc-fix-current)
inoremap <silent><expr> <c-space> coc#refresh()
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nmap <silent> <space><space> :<C-u>CocList<cr><Paste>
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172
let g:vimfiler_as_default_explorer = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:ale_lint_on_insert_leave = 1
"let g:ale_completion_max_suggestions = 1
"let g:ale_open_list = 1

let g:deoplete#enable_at_startup = 1
" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"  \ "\<Plug>(neosnippet_expand_or_jump)"
"   \: "\<TAB>"

nmap gx <Plug>(openbrowser-smart-search)
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

autocmd FileType systemverilog let b:coc_pairs_disabled = ['<',"'"]
