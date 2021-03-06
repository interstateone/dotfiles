"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Other performance tweaks
set ttyfast
set synmaxcol=128
set nocursorcolumn

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set number

" Disabling because of poor performance
" set rnu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme Tomorrow-Night

" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader
let mapleader= "\<Space>"
let maplocalleader= "\<Space>"
" Move up and down directly, not linewise
:nmap j gj
:nmap k gk

" Clear search highlight
:nmap <leader>q :nohlsearch<CR>

" Navigate splits without <C-W> prefix
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Command mode readline-style movements
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 250

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set autoindent

" Apply substitutions globally
set gdefault

set list
set listchars=nbsp:⦸,trail:·,tab:▷┅

" Investigate
let g:investigate_use_dash=1
let g:investigate_dash_for_swift="objc"
nnoremap <leader>d :call investigate#Investigate()<CR>

" Markdown
let g:vim_markdown_folding_disabled=1

let g:gitgutter_realtime = 0

" Force setting for *.md files. More info:
" https://github.com/tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Xcode
autocmd FileType objc compiler xcodebuild
autocmd FileType swift compiler xcodebuild
let g:dispatch_compilers = {
    \ 'make': 'xcodebuild',
    \ 'fastlane': 'xcodebuild'}
let g:xcode_run_command = 'Dispatch {cmd}'

" fastlane
au BufNewFile,BufRead Fastfile,Appfile,Snapfile,Gymfile,Matchfile,Deliverfile set filetype=ruby

autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype swift setlocal ts=4 sw=4 sts=0 expandtab

" Spell checking
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell
set spelllang=en_us
set spellfile=$HOME/.vim-spell-en.utf-8.add

" clang_complete
" Disable auto completion, always <c-x> <c-o> to complete
let g:clang_complete_auto = 1
let g:clang_use_library = 1
let g:clang_periodic_quickfix = 0
let g:clang_close_preview = 1

" For Objective-C, this needs to be active, otherwise multi-parameter methods
" won't be completed correctly
let g:clang_snippets = 1

" Snipmate does not work anymore, ultisnips is the recommended plugin
let g:clang_snippets_engine = 'ultisnips'

" This might change depending on your installation
let g:clang_exec = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

set shell=/bin/bash

" ripgrep
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --hidden
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  let g:ackprg = 'rg --vimgrep --no-heading --hidden'

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg --files --no-ignore --hidden --follow --glob "!.git/*" %s'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:ctrlp_extensions = ['iOSSim', 'tag']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = "r"
let g:ctrlp_root_markers = ['project.clj']
let g:ctrlp_max_files=0
nnoremap <Leader>r :CtrlPTag<cr>

" ctags optimization
set tags=tags;

" tagbar
nnoremap <Leader>t :TagbarToggle<CR>

set paste

" Smartly join commented lines
set formatoptions+=j

" Folding
hi Folded ctermbg=238
let &fillchars='vert:┃'             " less cluttered vertical window separators
set foldmethod=indent               " not as cool as syntax, but faster
set foldlevelstart=99               " start unfolded

"""""""""""""""""""""""""""""
" Custom Commands
"""""""""""""""""""""""""""""

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" RSpec.vim mappings
map <Leader>u :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch rspec {spec}"

let g:xcodebuild_run_command = "call dispatch#compile_command(0, '{cmd}', 11)"
:nnoremap gr :grep <cword> *<CR>

" Source the vimrc file after saving it
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Status line
" Always show a status line.
set laststatus=2                  

hi clear StatusLine
hi clear StatusLineNC
hi StatusLine   term=bold cterm=bold ctermfg=245 ctermbg=235
hi StatusLineNC term=bold cterm=bold ctermfg=245 ctermbg=235

set statusline=%=                                 " switch to RHS
set statusline+=%m%r                              " modified, readonly
set statusline+=\ 
set statusline+=%{expand('%:h')}/                 " relative path to file's directory
set statusline+=%t                                " file name
set statusline+=\ 
