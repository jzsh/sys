"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle {{{1

" needed to run vundle
set nocompatible
filetype off

" set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim

" start vundle environment
call vundle#begin()

" let Vundle manage Vundle (this is required)
Plugin 'VundleVim/Vundle.vim'

" install/update/delete a plugin
" 	:PluginInstall
"   :PluginUpdate
"   :PluginClean

" YOUR LIST OF PLUGINS GOES HERE LIKE THIS:
Plugin 'bling/vim-airline'
Plugin 'altercation/solarized'
Plugin 'tomasr/molokai'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
" Plugin 'vim-scripts/colorsupport.vim'
" Plugin 'JamshedVesuna/vim-markdown-preview'
" Plugin 'MikeCoder/markdown-preview.vim'
Plugin 'iamcco/markdown-preview.vim'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'chxuan/change-colorscheme'
" Plugin 'vim-scripts/Smart-Tabs'
Plugin 'vim-scripts/taglist.vim'
" add plugins before this
call vundle#end()
filetype plugin indent on    " required



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

set nu                                 	" show line number
set list                                " donot show blank char
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
set noexpandtab                         " or expandtab
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

"trick: automatically set paste mode in Vim when pasting in insert mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
