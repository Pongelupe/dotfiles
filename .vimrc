let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='deus'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

Plug 'mateusbraga/vim-spell-pt-br'
Plug 'kamykn/spelunker.vim'
let g:spelunker_disable_uri_checking = 1
Plug 'ap/vim-css-color'


Plug 'preservim/nerdcommenter'
let g:NERDCreateDefaultMappings = 1
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
let g:instant_markdown_theme = 'dark'
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_mathjax = 1


" latex
Plug 'aclements/latexrun'
Plug 'lervag/vimtex'
Plug 'joom/latex-unicoder.vim'
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
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
Plug 'vim-python/python-syntax'

Plug 'untitled-ai/jupyter_ascending.vim'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'Jorengarenar/vim-SQL-UPPER'
call plug#end()

set background=dark
colors deus
set number relativenumber
set linebreak
set nobackup
set wildmode=longest,list
set expandtab
set tabstop=2
set hlsearch
set nospell

nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader = ","

filetype plugin on

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert
" set 'updatetime' to 15 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore
