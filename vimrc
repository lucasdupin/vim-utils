" File: .vimrc
" Author: Lucas 
" Description: My vim helpers, based on Frangossauro's .vimrc 

" Pathogen!"
scriptencoding utf-8

" Vundle setup
set nocompatible
filetype off
call plug#begin()

" Plugins:
Plug 'VundleVim/Vundle.vim'
Plug 'rking/ag.vim'
Plug 'vim-stylus'
Plug 'ctrlp.vim'
Plug 'editorconfig-vim'
Plug 'The-NERD-tree'
Plug 'othree/html5.vim'
Plug 'bling/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'gitignore'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ruby.vim'
Plug 'othree/yajs.vim'
Plug 'delimitMate.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'surround.vim'
Plug 'lepture/vim-jinja'

call plug#end()
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

set background=dark
"colorscheme solarized
let g:solarized_termcolors= 256
let g:solarized_termtrans= 1
colorscheme Molokai
"colorscheme Badwolf
"set t_Co=256

" General
set vb                          " Visual bell
""set nobk nowb noswf             " Disable backup
set lazyredraw                  " Don't update while in macro
set ttyfast                     " Improves redrawing
set title                       " Enable window title
set titlestring=%f%(\ [%M]%)    " Display filename in terminal window
set ruler                       " Show current line number on bar
""set showcmd                     " Show commands at bottom right
set showmode                    " Show current mod
set splitbelow                  " Split windows BELOW current window!
""set hidden                      " Allow hidden buffers
set complete=.,w,b,u,U,t,i,d    " Extra powerful completions :P
set modeline modelines=5        " Respect modeline if the file has one in the first 5!
set enc=utf-8                   " UTF-8 Default encoding
set encoding=utf-8
set number                      " Line Numbers"
set numberwidth=1               " Line number column narrow as possible
set cpoptions+=>                " Items in register separated by newline  
set autoread                    " Reload files when they change

"" Disable backup
set nobackup
set nowritebackup
set noswapfile

" Search into files"
set grepprg=ack

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" ??
set more
set report=0                    " Always report the number of lines changed
set display=lastline            " Show as much of the last line as possible 
""set ttimeoutlen=50
""set laststatus=2

" Highlight current curslor line
set cursorline                  " Show a cursor in the current line
hi CursorLine   cterm=bold
hi TabLine      cterm=bold,underline ctermfg=8 ctermbg=none
hi TabLineSel   cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill  cterm=bold ctermbg=none
hi TabLine      cterm=bold,underline ctermfg=8 ctermbg=none
hi TabLineSel   cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill  cterm=bold ctermbg=none

" Command-line completion
set wildmode=longest:full,list:full
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db,*.swc
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn|tmp)|bower_components|node_modules)$'
"let g:ctrlp_user_command = {
"  \ 'types': {
"  \   1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
"  \   2: ['.hg', 'hg --cwd %s locate -I .'],
"  \  },
"  \ 'fallback': 'find %s -type f'
"  \ }

" AutoComplete in Vim
set infercase
set completeopt=longest,menu
set ofu=syntaxcomplete#Complete
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Scroll
set nostartofline
set scrolloff=10         " At Least 5 lines above/below cursor

" Text formatting, identing, tabbing
set autoindent
""set smarttab
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
""set nojoinspaces
set backspace=indent,eol,start                              " Allow backspacing over anything 
set list listchars=tab:·-,trail:·,extends:> ",eol:¬
let indent_guides_start_level=2
let indent_guides_guide_size=2

set formatoptions-=t
set formatoptions+=corqn
"                  |||||
"                  ||||+-- Recognize numbered lists
"                  |||+--- Allow formatting of comments with 'gq'
"                  ||+---- Insert comment leader after <Enter>
"                  |+----- Insert comment leader after o/O
"                  +------ Auto-wrap comments

" Folding
set foldmethod=marker
set foldcolumn=1

" Search Configuration
""set ignorecase              " make searches case-insensitive, unless they contain upper-case letters:
set incsearch               " Incremental search
set hlsearch                " Highligh searches 
""set gdefault                " Assume /g flag on :s searches

" Code configs 
syntax on
set showmatch            " Show matching brackets
set mat=5
set matchpairs=(:),{:},[:],<:>

" Airline
let g:airline_powerline_fonts = 1

"""
""" Extensions
"""

"
"" Improve Vim copy for OSX terminal 
if has('gui_running')
    set mousefocus          " Mouse can control splits
    set mouse=a
    set transparency=5

    set fuoptions=maxvert,maxhorz

    " Dont show shitty toolbar
    set go-=T to 

endif

"
" Stuff that will make my life easiear when writing CoffeeScript"
"
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufRead *.eco set filetype=html

"
" TabBar (minibufexpl++)
"
let g:Tb_SplitBelow     = 0
let g:Tb_UseSingleClick = 1

"
"" Mappings
"let mapleader = ","

" Slightly more familiar indent on visual mode
"noremap <tab>       >gv
"noremap <s-tab>     <gv

"" Scrolling
map <S-Down> <C-E>
map <S-Up> <C-Y>
no J 10j
no K 10k

"" Copy and paste
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR> 

" Increment/decrement numbers
nn = <c-a>
nn + <c-x>

nmap :W :w
nmap :Q :q
nmap :Wq :wq

" Space to select a file
map <space> :CtrlP <CR>


" Buffer editing
nn <Leader>j       <C-W>j<C-W>_
nn <Leader>k       <C-W>k<C-W>_
nn <Leader>=       <C-W>=

" FileTree Browser
nn <Leader>d       <ESC>:NERDTreeToggle<cr>

nn <Leader>n       <ESC>:set number! number?<cr>

nn <Leader>e       <ESC>:TlistToggle<Cr>

" My beloved leaders <3
nn <Leader>w       <ESC>:w<Cr>
nn <Leader>s       <ESC>:Ag 
nn <Leader>r       <ESC>:make<Cr>
nn <Leader>o       <ESC>:make open<Cr>
nn <Leader>p       <Esc>:CtrlP<Cr>
nn <Leader>l       <Esc>:CtrlPClearCache<Cr>
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

let Tlist_File_Fold_Auto_Close = 1

" Shit, something is over my shoulder, my code
" is super secret. QUIT NOW, I REPEAT, NOW
nn <Leader>q        <ESC>:x<Cr>

" Visual mode
xno v   <esc>
xno <Leader>=  :Align =<CR>     

" Yank to all app's
xno <Leader>y !pbcopy<cr><esc>u 
nmap <silent> <Leader>p :SmartPaste<cr>

" Fullscreen "
nmap <Leader>c :set invfullscreen<cr>

" Map space key to fold/unfold!
""nnoremap <space> za
""vnoremap <space> zf

"
"" FileType shitty!
"

au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim


" Enable actionscript helpers
au FileType actionscript set dictionary+=~/.vim/dict/actionscript.dict
au FileType actionscript set makeprg=rake
au FileType as3 set efm=%C%.%#,%E%f(%l) col %c\ Error %m
autocmd BufRead,BufNewFile *.as set filetype=actionscript
set complete+=k

" Interpret python code under the visual cursor 
au FileType python set makeprg=python\ %
au FileType python vnoremap ,r :!python<cr> 

" Waf scripts recognition
au BufNewFile,BufRead wscript set syntax=python

" Make sure paste mode is on before pasting
function! SmartPaste()
    set paste
    normal! p`[=`]
    set nopaste
endfunction
command! -bar SmartPaste :call SmartPaste()

" Fix the search in visual mode.
" Only search the selected text
vnoremap /          <Esc>/\%V

" Avoid some stupid typing when substituing 
" variables in visual mode
vnoremap r          <Esc>:'<,'>B s/\<.*\>/

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/
let g:Powerline_symbols = "fancy"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"let g:ycm_cache_omnifunc = 1
"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" HTML checker is slow
let g:syntastic_html_checkers=[]

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
