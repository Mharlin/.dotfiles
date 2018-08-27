if &compatible
  set nocompatible
end

" Remove declared plugins
function! s:UnPlug(plug_name)
  if has_key(g:plugs, a:plug_name)
    call remove(g:plugs, a:plug_name)
  endif
endfunction
command!  -nargs=1 UnPlug call s:UnPlug(<args>)

let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'christoomey/vim-run-interactive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'janko-m/vim-test'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'maksimr/vim-jsbeautify'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }
Plug 'junegunn/fzf'
Plug 'neovimhaskell/haskell-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'

if g:has_async
  Plug 'w0rp/ale'
endif

call plug#end()

syntax on
filetype plugin on
filetype plugin indent on

" Remove delay for Esc key
set timeoutlen=1000 ttimeoutlen=0

" Haskell config
let g:LanguageClient_serverCommands = { 'haskell': ['hie', '--lsp'] }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set termguicolors
lang en_US

" Use deoplete / previously called neocomplete
let g:deoplete#enable_at_startup = 1

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif


set clipboard=unnamed
set mouse=

set background=dark
colorscheme solarized

let g:has_async = v:version >= 800 || has('nvim')

augroup vimrcEx
   autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
   autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

        " Set syntax highlighting for specific file types
   autocmd BufRead,BufNewFile Appraisals set filetype=ruby
   autocmd BufRead,BufNewFile *.md set filetype=markdown
   autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

   " ALE linting events
   if g:has_async
      set updatetime=1000
      let g:ale_lint_on_text_changed = 0
      autocmd CursorHold * call ale#Lint()
      autocmd CursorHoldI * call ale#Lint()
      autocmd InsertEnter * call ale#Lint()
      autocmd InsertLeave * call ale#Lint()
   else
      echoerr "The thoughtbot dotfiles require NeoVim or Vim 8" 
   endif 
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

"Font
set guifont=Menlo:h16

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" info at https://github.com/mileszs/ack.vim
if executable('ag')

  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s --exclude-standard'
  let g:ctrlp_custom_ignore = '\v[\/](reverse-engineer)|\.git'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep!  <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Make it obvious where 120 characters is
set textwidth=120
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
endfunction

inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Always use vertical diffs
set diffopt+=vertical

" Change the cursor when you are in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Close Nerdtree if it's the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Map Nerdtree treeview to F2 and F3
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Tagbar
nnoremap <leader>. :CtrlPTag<cr>
nmap <F8> :TagbarToggle<CR>

" Ultisnips - snippet manager
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Multicursor
let g:multi_cursor_exit_from_insert_mode=0

" Json format
vmap =j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"<CR><CR>
nmap =j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"<CR>

" Search visual selection
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" JsBeautify
autocmd FileType javascript noremap <buffer>  <c-=> :call RangeJsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-=> :call RangeJsonBeautify()<cr>
autocmd FileType html noremap <buffer> <c-=> :call RangeHtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-=> :call RangeCSSBeautify()<cr>

" Ignore for Ctrl-p
set wildignore+=*/target/*

" save read-only files with w!!
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
