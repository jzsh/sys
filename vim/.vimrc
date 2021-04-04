""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Plugin setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'dense-analysis/ale'
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         basic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set helplang=en                         " |cn set default language of help document if installed
set autoread                            " autoread file
"autocmd! BufWritePost .vimrc source %    " aotuload .vimrc
" set paste                             " Put Terminal-Vim in Paste mode

syntax on
set t_Co=256                            " set 256 color
colorscheme molokai
" colorscheme solarized
" colorscheme desert
" colorscheme github
set background=dark                     " dark/light

" Highlight current row and column
set cursorline
" set cursorcolumn
" highlight CursorLine   guibg=dark guifg=black ctermbg=000000 ctermfg=NONE
" highlight CursorColumn guibg=dark guifg=black ctermbg=000000 ctermfg=NONE

set nu                                 " show line number
set nolist                             " donot show blank char
set listchars=tab:>\ ,trail:.

""""Status Bar""""
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2                        " always show the status line

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set fileformats=unix,dos                "set file format when saving new buffer

" indent setting
let g:tw=[2,4,8]
let g:tid=1
set expandtab                           " or expandtab
set tabstop=4                           " width of TAB
set shiftwidth=0                        " Set it same as tabstop value
set autoindent
set backspace=indent,eol,start

autocmd FileType python set expandtab
nnoremap <silent> <F2> :let tid=(tid+1)%3<cr> <bar> :let &tabstop=tw[tid]<cr>

" Search/Replace
set hlsearch
set incsearch
set ignorecase
set smartcase

set clipboard+=unnamed

set mouse=a                             " a:use mouse in all mode
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

set nowrap                              " do not wrap line

" Coding style
if exists('+colorcolumn')
	set colorcolumn=120
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
endif

""""fold""""
"set foldmethod=syntax
set foldmethod=indent
set nofoldenable

" Plugin Settings
""""set ctags & taglist""""
set tags+=./tags,tags;
set tags+=/usr/include/tags

set autochdir            	 " auto chdir to where current file located

let Tlist_Auto_Open=0
let Tlist_Exit_OnlyWindow=1

"""""""""" NERDTree """""""""
" close NERDTree if it is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" since <A-T> can't work, typing <C-V><A-T> ==> t  
nmap t :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Keyboard Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
nnoremap <silent> <F1> :Tlist<CR>
" Saving file
nmap <leader>w :w!<cr>
command! W exec 'w !sudo tee % > /dev/null'
" Scrolling
set scrolloff=5  " set cursor line in the middle of window
noremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


noremap <F7> 10zh
inoremap <F7> <ESC>10zhi
noremap <F8> 10zl
inoremap <F8> <ESC>10zli
" delete trailng whitespace
nnoremap <silent> <Space><Space><Space> :%s/\s\+$//<cr>:set nohlsearch<cr>:echo "trailing space deleted"<cr>

" Windows
" Open split windows to the below/right
set splitbelow
set splitright
" Faster window switching
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
nmap <c-n> <c-w><c-w>

"  Auto complete block
inoremap () ()<left>
inoremap ;; <ESC>$a;<ESC>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap '; '';<left><left>
inoremap <> <><left>
inoremap [[ []<right>;<left><left>
inoremap ]] []<right>
inoremap [] []<left>
inoremap {} {}<left>
inoremap //c /*  */<left><left><left>
inoremap {<cr> {<cr>}<ESC>O
inoremap <leader>l <ESC>$a
noremap <leader>ff :echo expand('%:p')<CR>
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" win
vnoremap <silent> <C-C> "+y

" buffers
noremap <C-6> <Nop>
nnoremap ,bn :bn<cr>
nnoremap ,b :ls<CR>:buffer<Space>
" move
nnoremap  00 $

" Insert current time
noremap <leader>date :r !date -R <cr> 

"inoremap <silent> <2-LeftMouse> *

" Map key to toggle opt
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Display-altering option toggles
MapToggle <F3> list
MapToggle <F4> wrap
MapToggle <F5> hlsearch

nmap <F9> :PreviousColorScheme<cr>
nmap <F10> :NextColorScheme<cr>

"""""Plugin setting"""""
" syntastic
let g:syntastic_cpp_compiler_options = '-std=c++11' " Open c++11 flag for gcc

"trick: automatically set paste mode in Vim when pasting in insert mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"" ale settings

let g:ale_lint_on_text_changed = 'never'    " run lint only on saving a file
let g:ale_lint_on_enter = 0                 " dont run lint on opening a file
" let g:ale_sign_error = 'x'
" let g:ale_sign_warning = '!'
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
