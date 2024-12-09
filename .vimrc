let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set number relativenumber
set linebreak
set nobackup
set wildmode=longest,list
set expandtab
set tabstop=2
set hlsearch
set nospell
set spelllang=en_us
set encoding=utf-8

nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader = ","

filetype plugin on
syntax enable
set nocompatible

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert
" set 'updatetime' to 15 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore

call plug#begin()
" git
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'


" appearance, UI utils and text editing
Plug 'ajmwagar/vim-deus'
Plug 'preservim/nerdtree'
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.aux$', '\.bbl$', '\.fls$', '\.lof$', '\.lot$']
nmap <F2> :NERDTreeToggle<CR>
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'mhinz/vim-startify'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'farmergreg/vim-lastplace'
Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='deus'
Plug 'preservim/nerdcommenter'
let g:NERDCreateDefaultMappings = 1
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'MattesGroeger/vim-bookmarks'

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F1> :call ToggleQuickFix()<cr>


" writing
Plug 'sheerun/vim-polyglot'

Plug 'dbmrq/vim-ditto'
" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
au FileType markdown,text,tex,md DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off
nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches

Plug 'preservim/vim-wheel'
let g:wheel#map#up   = '<c-k>'
let g:wheel#map#down = '<c-j>'

Plug 'kamykn/spelunker.vim'
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_email_checking = 1
let g:spelunker_disable_acronym_checking = 1
let g:spelunker_disable_backquoted_checking = 1
let g:spelunker_highlight_type = 2
let g:spelunker_disable_auto_group = 1
augroup spelunker
  autocmd!
  autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md,*.tex call spelunker#check()
augroup END
Plug 'farconics/victionary'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled = 1
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
let g:instant_markdown_theme = 'dark'
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_mathjax = 1

" latex
Plug 'aclements/latexrun'
Plug 'lervag/vimtex'
Plug 'joom/latex-unicoder.vim'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:Tex_IgnoredWarnings = 
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 99


" specific programming language

Plug 'untitled-ai/jupyter_ascending.vim'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

Plug 'Jorengarenar/vim-SQL-UPPER'
call plug#end()

set background=dark
colors deus
