set exrc
set secure
set nocompatible
set shortmess+=A
set encoding=utf-8
set renderoptions=type:directx,level:0.75,gamma:1.25,contrast:0.25,geom:1,renmode:5,taamode:1
set t_Co=256



filetype off

set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
"-------------------------------------------
call vundle#begin('$HOME/vimfiles/bundle/')
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/seoul256.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'cskeeters/vim-smooth-scroll.git'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'srcery-colors/srcery-vim.git'
Plugin 'yegappan/findstr.git'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"-------------------------------------------

let mapleader = "-"
let g:AutoPairsShortcutFastWrap=''

nnoremap S <C-w>r
nnoremap <C-c> I//<esc>
nnoremap <C-u> 0wxx
inoremap jk <esc>
vnoremap jk <esc>
onoremap jk <esc>
inoremap <S-j> ()
inoremap <S-k> {}
inoremap <S-l> []
inoremap å *
inoremap Å &
inoremap ö <BS>
inoremap Ö <C-n>
map <space> mf
nnoremap d d`f
nnoremap vv v$
nnoremap z zz
nnoremap <leader>f :Findstring<cr>
nnoremap <leader>g :YcmCompleter GoTo<cr>
map <leader>c <esc>

nnoremap <leader>j viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>k viw<esc>a}<esc>bi{<esc>lel
nnoremap <leader>l viw<esc>a]<esc>bi[<esc>lel

nnoremap <silent> <F5> :!start "..\build\dev.exe" <CR>
nnoremap <esc> <C-w>c
nnoremap <C-h> :nohl<CR>

" window switching
nnoremap s <C-w>w

nnoremap <C-s> :wa<CR>


set fillchars+=vert:\ 
set wrapmargin=30
set autoread
set nosol
set hlsearch
set autochdir
set cindent
set autoindent
set smartindent
set softtabstop=3
set shiftwidth=3
set guifont=Liberation\ Mono:h14:b
set backspace=indent,eol,start
set incsearch
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set laststatus=2
set cmdheight=2
set ignorecase
set smartcase
set noshowmode
set antialias
set switchbuf-=split
set hidden

" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_map = '<C-n>'
let g:ctrlp_match_window = 'top,order:btt,min:1,max:20,results:50'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_user_command =
    \ 'dir %s /-n /b /s /a-d | findstr /i /l ".c .h .bat"' " Windows
nnoremap t :CtrlPBuffer<CR>
nnoremap <C-j> :CtrlPCurWD<CR>
nnoremap <C-l> :CtrlPLine<CR>

" CtrlPFunky
nnoremap <C-f> :CtrlPFunky<CR>
let g:ctrlp_funky_sort_by_mru = 1
let g:ctrlp_funky_multi_buffers = 1


" AsyncRun
let g:asyncrun_open = 8

" YCM
let g:ycm_show_diagnostics_ui = 0
set completeopt-=preview

" Airline
let g:airline_theme = 'minimalist'

" Findstr
let Findstr_Default_Filelist = '*.c *.h'

let g:ycm_use_clangd = 1

colorscheme srcery


"set background=dark


au GUIEnter * simalt ~x

hi clear SignColumn
syntax on

"caret color stuff
highlight Cursor guifg=white guibg=red
highlight iCursor guifg=white guibg=green
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=a:blinkon0

hi NonText guifg=bg

" Thanks to https://forums.handmadehero.org/index.php/forum?view=topic&catid=4&id=704#3982
" error message formats
" Microsoft MSBuild
set errorformat+=\\\ %#%f(%l\\\,%c):\ %m
" Microsoft compiler: cl.exe
set errorformat+=\\\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m
" Microsoft HLSL compiler: fxc.exe
set errorformat+=\\\ %#%f(%l\\\,%c-%*[0-9]):\ %#%t%[A-z]%#\ %m


"vimrc mappings
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>s :so $MYVIMRC<CR>

function! DoBuildBatchFile()
   :normal :w<CR>
   " build.bat
   set makeprg=build
   " Make sure the output doesnt interfere with anything
   silent make
   " Open the output buffer
   cwindow 5
   echo 'Build Complete'
   ":normal s
endfunction

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
nnoremap '/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=50
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=50
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction


"Go to previous error
nnoremap <F7> :cp<CR><CR>
"Go to next error
nnoremap <F8> :cn<CR><CR>

nnoremap , :wa<CR> :call DoBuildBatchFile()<CR>
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

set cursorline
highlight CursorLine guibg=#100000 guifg=fg
autocmd InsertLeave * highlight CursorLine guibg=#100000 guifg=fg
autocmd InsertEnter * highlight CursorLine guibg=#000000 guifg=fg

" No error sounds
set noerrorbells visualbell t_vb=0
autocmd GUIEnter * set visualbell t_vb=0

autocmd BufRead *.c :normal ggVG=
autocmd BufRead *.cpp :normal ggVG=

