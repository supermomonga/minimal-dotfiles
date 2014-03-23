
set nocompatible

" ========================================================================
" Autocmd group
" ========================================================================
augroup MyAutoCmd
  autocmd!
augroup END


" ========================================================================
" Encoding
" ========================================================================
let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac


" ========================================================================
" Appearance
" ========================================================================

" Don't ring a bell and flash
set vb t_vb=

" Show line number
set number

" Always show tab
set showtabline=2

" Show invisible chars
set list

" When input close bracket, show start bracket
set showmatch

" Fix zenkaku chars' width
set ambiwidth=double


" ========================================================================
" Syntax
" ========================================================================
syntax enable


" ========================================================================
" Backup
" ========================================================================
set dictionary=~/.vim/tmp/swap
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo

if has('persistent_undo')
  set undodir=./.vimundo,~/.vim/tmp/undo
  autocmd MyAutoCmd BufReadPre ~/* setlocal undofile
endif


" ========================================================================
" History
" ========================================================================
" Command history
set history=10000


" ========================================================================
" Restore
" ========================================================================
" Restore last cursor position when open a file
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" ========================================================================
" Indent
" ========================================================================
" Use Space instead of Tab to make indent
set expandtab

" TODO: Width of tab?
" TODO: Ato de yoku shiraberu.
set tabstop=2

" Hoe many spaces to each indent level
set shiftwidth=2

" Automatically adjust indent
set autoindent

" Automatically indent when insert a new line
set smartindent

" Insert an indent when keydown <Tab> in indent spaces
set smarttab

" Symbols to use indent or other
" NOTE: kakkoii unicode moji
" - http://unicode-table.com/en/sections/dingbats/
" - http://unicode-table.com/en/sections/spacing-modifier-letters/
" 		test   
set listchars=tab:❯\ ,trail:˼,extends:»,precedes:«,nbsp:%


" ========================================================================
" Movement
" ========================================================================
" BS can delete newline or indent
set backspace=indent,eol,start
" Can move at eol, bol
set whichwrap=b,s,h,l,<,>,[,]


" ========================================================================
" Search
" ========================================================================
" incremental search
set incsearch

" Match words with ignore upper-lower case
set ignorecase

" Don't think upper-lower case until upper-case input
set smartcase

" Highlight searched words
set hlsearch


" ========================================================================
" Buffer handling
" ========================================================================
" Can change buffer in window no matter buffer is unsaved
set hidden


" ========================================================================
" Mapping
" ========================================================================
" [Emacs] <C-e> to end of line
nnoremap <C-e>  $

" [Emacs] <C-k> to delete a line
nnoremap <C-k>  dd

" Toggle 0 and ^
nnoremap <expr>0  col('.') == 1 ? '^' : '0'
nnoremap <expr>^  col('.') == 1 ? '^' : '0'

" : without <Shift>
nnoremap ;  :
nnoremap :  ;

" _ : Quick horizontal splits
nnoremap _  :sp<CR>

" | : Quick vertical splits
nnoremap <bar>  :vsp<CR>

" N: Find next occurrence backward
nnoremap N  Nzzzv
nnoremap n  nzzzv

" Backspace: Act like normal backspace
" TODO: Mac OS X doesn't have <BS>. have delete key.
nnoremap <BS>  X

" cmdwin
nnoremap :  q:i

" TODO: Move those settings to right section
autocmd MyAutoCmd CmdwinEnter [:>] iunmap <buffer> <Tab>
autocmd MyAutoCmd CmdwinEnter [:>] nunmap <buffer> <Tab>

" JK peropero
" Use logical move instead of physical ones
nnoremap j gj
nnoremap k gk

" Easy to make selection to pars
" TODO: u-n, iranai kamo...
onoremap ) f)
onoremap ( t(

" Insert space in normal mode easily
nnoremap <C-l>  i<Space><Esc><Right>
nnoremap <C-h>  i<Space><Esc>


" ========================================================================
" NeoBundle
" ========================================================================
" To use NeoBundle, manually add to runtimepath
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" To load remote plugin
call neobundle#rc(expand("~/.vim/bundle"))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'


" ========================================================================
" Vimproc
" ========================================================================
NeoBundle 'Shougo/vimproc.vim', { 'build' : {
      \   'windows' : 'mingw32-make -f make_mingw32.mak',
      \   'cygwin'  : 'make -f make_cygwin.mak',
      \   'mac'     : 'make -f make_mac.mak',
      \   'unix'    : 'make -f make_unix.mak',
      \ }}


" ========================================================================
" Unite.vim
" ========================================================================
NeoBundle 'Shougo/unite.vim', { 'depends' : [ 'Shougo/vimproc.vim' ] }
NeoBundle 'ujihisa/unite-locate', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'Shougo/neomru.vim', { 'depends' : [ 'Shougo/unite.vim' ] }

let g:unite_force_overwrite_statusline = 0
let g:unite_kind_jump_list_after_jump_scroll=0
let g:unite_enable_start_insert = 0
let g:unite_source_rec_min_cache_files = 1000
let g:unite_source_rec_max_cache_files = 5000
let g:unite_source_file_mru_long_limit = 100000
let g:unite_source_file_mru_limit = 100000
let g:unite_source_directory_mru_long_limit = 100000
let g:unite_prompt = '❯ '

nnoremap <silent> <Space>f  :<C-u>Unite -start-insert -buffer-name=files buffer_tab file_mru<CR>
nnoremap <silent> <Space>b  :<C-u>Unite -start-insert buffer<CR>


" ========================================================================
" VimShell
" ========================================================================
NeoBundle 'Shougo/vimshell.vim', { 'depends' : [ 'Shougo/vimproc.vim' ] }
NeoBundle 'supermomonga/vimshell-pure.vim', { 'depends' : [ 'Shougo/vimshell.vim' ] }

nnoremap <Space>vp  :<C-u>VimShellPop -toggle<CR>
nnoremap <Space>vb  :<C-u>VimShellBufferDir<CR>
nnoremap <Space>vd  :<C-u>VimShellCurrentDir<CR>
nnoremap <Space>vv  :<C-u>VimShell<CR>

function! s:my_vimshell_mappings()
  imap <buffer> <C-e>  <ESC>$a
  imap <buffer> <C-d>  <ESC><Right>xi
  imap <buffer> <C-/>  <ESC>dT/xa
  imap <buffer> <C-.>  <ESC>dT.xa
  imap <buffer> <C-_>  <ESC>dT_xa
endfunction
autocmd MyAutoCmd FileType vimshell call s:my_vimshell_mappings()


" ========================================================================
" Neocomplete
" ========================================================================
NeoBundle 'Shougo/neocomplete.vim'

" Enable at startup
let g:neocomplete#enable_at_startup = 1

" Smartcase
let g:neocomplete#enable_smart_case = 1

" Enable _ separated completion
let g:neocomplete_enable_underbar_completion = 1

" Minimum length to cache
let g:neocomplete_min_syntax_length = 3

" Max size of candidates to show
let g:neocomplete#max_list = 1000

" How many length to need to start completion
let g:neocomplete_auto_completion_start_length = 2

" Auto select the first candidate
" let g:neocomplete_enable_auto_select = 1

" Force to overwrite complete func
let g:neocomplete_force_overwrite_completefunc = 1

" let g:neocomplete_enable_camel_case_completion = 1
let g:neocomplete#skip_auto_completion_time = '0.2'


" ========================================================================
" Textobj
" ========================================================================
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'osyo-manga/vim-textobj-multiblock', { 'depends' : 'kana/vim-textobj-user' }

let g:textobj_multiblock_blocks = [
      \   ['(', ')', 1],
      \   ['[', ']', 1],
      \   ['{', '}', 1],
      \   ['<', '>', 1],
      \   ['"', '"', 1],
      \   ["'", "'", 1],
      \   ['`', '`', 1],
      \   ['|', '|', 1],
      \ ]
let g:textobj_multiblock_search_limit = 20


" ========================================================================
" 
" ========================================================================


" ========================================================================
" Filetype plugin and indent on
" ========================================================================
filetype plugin indent on
