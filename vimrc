" vim:ft=vim:foldmethod=marker

let $VIMBASE=$HOME."/vimfiles"

source $VIMBASE/startup/settings

filetype off    

set rtp+=$VIMBASE/dein

let $PLUGIN_BASE = expand($VIMBASE.'/plugins/')

if dein#load_state($PLUGIN_BASE)
  call dein#begin($PLUGIN_BASE)

  call dein#add(expand($VIMBASE.'/dein.vim/'))

  "base {{{
  call dein#add('asek-ll/asek-ll.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('lyokha/vim-xkbswitch')
  call dein#add('scrooloose/nerdtree.git')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('kien/ctrlp.vim.git')
  call dein#add('tpope/vim-surround')
  call dein#add('bling/vim-airline')
  call dein#add('Raimondi/delimitMate.git')
  call dein#add('terryma/vim-multiple-cursors')
  "}}}

  "programming {{{
  call dein#add('scrooloose/nerdcommenter.git')
  call dein#add('majutsushi/tagbar.git')
  call dein#add('godlygeek/tabular')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('tpope/vim-fugitive')
  call dein#add('lepture/vim-velocity')
  call dein#add('duganchen/vim-soy')
  call dein#add('scrooloose/syntastic.git')
  "call dein#add('mhinz/vim-startify')
  "call dein#add('jaxbot/brolink.vim')
  call dein#add('fatih/vim-go')
  "}}}

  "neocomplete {{{
  call dein#add('Shougo/neocomplete')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('SirVer/ultisnips')
  "call dein#add('honza/vim-snippets')
  "}}}

  "javascript {{{
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('vim-scripts/JavaScript-Indent')
  call dein#add("maksimr/vim-jsbeautify")
  "}}}

  "other {{{
  "call dein#add("kchmck/vim-coffee-script.git")
  "call dein#add('digitaltoad/vim-jade.git')
  "call dein#add('plasticboy/vim-markdown.git')
  "call dein#add('spf13/PIV.git')
  "}}}

  "source $VIMBASE/presets/javascript/js
  "source $VIMBASE/presets/neocomplete

  call dein#end()
  call dein#save_state()
endif

filetype plugin on
filetype plugin indent on
syntax enable

silent! colorscheme github

nmap <M-1> :NERDTreeFind<CR>
nmap <M-F1> :NERDTreeFind<CR>
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :TagbarToggle<CR>
nmap <F3> :CtrlP .<CR>
nmap <F4> :CtrlPBuffer<CR>
nmap <F5> :CtrlPMRUFiles<CR>
nmap <C-K> <leader>ci
vmap <C-K> <leader>ci

imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|_x)$'
      \ }

let g:airline_theme='dark'
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:indent_guides_enable_on_vim_startup = 1

if has("win32")
  set grepprg=findstr\ /n\ /s
endif
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory = expand($VIMBASE.'/snippets/')

let g:syntastic_enable_signs=1 
let g:syntastic_css_checkers=['csslint', 'prettycss']
let g:syntastic_go_checkers=['go', 'gofmt', 'govet']
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_javascript_jshint_args = "-c ". expand($VIMBASE . "/configs/.jshintrc")
let g:syntastic_javascript_jscs_args = "-c ". expand($VIMBASE . "/configs/.jscsrc")

let g:editorconfig_Beautifier = expand($VIMBASE . "/configs/.editorconfig")

let g:DisableAutoPHPFolding = 1 

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType javascript call JavaScriptFold()

autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

autocmd FileType python let g:runprg="!python %"
autocmd FileType autoit let g:runprg="!AutoIt3.exe %"

autocmd BufRead,BufNewFile *.inc set ft=php
autocmd BufRead,BufNewFile *.install set ft=php

