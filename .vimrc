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
set shiftwidth=2
set hlsearch
set nospell
set spelllang=en_us
set encoding=utf-8
set mouse=a
set updatetime=300
set signcolumn=yes

nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader = ","

augroup vimrc
  autocmd!
  " automatically leave insert mode after 'updatetime' milliseconds of inaction
  autocmd CursorHoldI * stopinsert
  " set 'updatetime' to 15 seconds when in insert mode
  autocmd InsertEnter * let g:updaterestore=&updatetime | set updatetime=15000
  autocmd InsertLeave * let &updatetime=g:updaterestore
augroup END

" let the dedicated plugins below own these filetypes (must be set before polyglot loads)
let g:polyglot_disabled = ['latex', 'rust', 'dart']
" Vim's java syntax highlights Java 23 `///` Markdown doc comments by loading
" syntax/markdown.vim, which resolves to polyglot's (mkd* group names) and fails with E28.
let g:java_ignore_markdown = 1

call plug#begin()
" local plugins
Plug '~/workspace/personal/kiro.vim'
Plug '~/workspace/personal/control-room.vim'
let g:control_room_use_dispatch = 1
nnoremap <leader>bb :ControlRoom<CR>
nnoremap <leader>bB :ControlRoom!<CR>
nnoremap <leader>bl :ControlRoomLast<CR>
nnoremap <leader>bt :ControlRoom test this class<CR>
nnoremap <leader>bw :ControlRoomWatch<CR>
nnoremap <leader>be :ControlRoomEdit<CR>
nnoremap <leader>bo :Copen<CR>
nnoremap <leader>bO :Copen!<CR>

" git
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'APZelos/blamer.nvim'
let g:blamer_enabled = 1


" appearance, UI utils and text editing
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'soft'
Plug 'ajmwagar/vim-deus'
Plug 'preservim/nerdtree'
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.aux$', '\.bbl$', '\.fls$', '\.lof$', '\.lot$']
nmap <F2> :NERDTreeToggle<CR>
nmap <F11> :NERDTreeFind<CR>
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
Plug 'andymass/vim-matchup'
let g:matchup_override_vimtex = 1
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
" show the control-room watch (e.g. watch:test) at the start of section x
function! AirlineControlRoom() abort
  let l:status = ControlRoomStatus()
  return empty(l:status) ? '' : l:status . ' ' . get(g:, 'airline_right_alt_sep', '|') . ' '
endfunction
function! s:AirlineControlRoom() abort
  call airline#parts#define_function('control_room', 'AirlineControlRoom')
  let g:airline_section_x = airline#section#create_right(['control_room']) . g:airline_section_x
endfunction
augroup vimrc_airline
  autocmd!
  autocmd User AirlineAfterInit call s:AirlineControlRoom()
augroup END
Plug 'preservim/nerdcommenter'
let g:NERDCreateDefaultMappings = 1
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'MattesGroeger/vim-bookmarks'
let g:bookmark_show_toggle_warning = 0
Plug 'itchyny/vim-highlighturl'
Plug 'dcorral/svgpreview-vim'
" language servers are configured in ~/.vim/coc-settings.json
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" UNIX related
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-eunuch'


" writing
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'sheerun/vim-polyglot'

Plug 'dbmrq/vim-ditto'
" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
augroup vimrc_ditto
  autocmd!
  autocmd FileType markdown,text,tex,md DittoOn
augroup END
" Turn Ditto on and off
nmap <leader>di <Plug>ToggleDitto
" Jump to the next / previous word
nmap =d <Plug>DittoNext
nmap -d <Plug>DittoPrev
" Ignore / stop ignoring the word under the cursor
nmap +d <Plug>DittoGood
nmap _d <Plug>DittoBad
" Show the next / previous matches
nmap ]d <Plug>DittoMore
nmap [d <Plug>DittoLess

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

" latex
Plug 'lervag/vimtex'
Plug 'joom/latex-unicoder.vim'
if has('mac')
  let g:vimtex_view_method = 'skim'
  let g:vimtex_view_skim_sync = 1
  let g:vimtex_view_skim_activate = 1
else
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
endif
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \ 'specifier changed to',
      \ 'You have requested',
      \ 'Missing number, treated as zero.',
      \ 'There were undefined references',
      \ 'Citation .* undefined',
      \ 'Double space found.',
      \]


" specific programming language

Plug 'untitled-ai/jupyter_ascending.vim'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" databases and SQL
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
call plug#end()

augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.keymap :setfiletype c
augroup END

" coc.nvim: completion
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc.nvim: navigation and refactoring
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction-cursor)
nmap <leader>qf <Plug>(coc-fix-current)
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>

" kotlin-lsp: go-to-definition into a dependency returns a jar:///...!/Foo.class
" URI; ask the server to decompile it into a read-only buffer.
function! s:KotlinLspDecompile(uri) abort
  let l:res = CocRequest('kotlin', 'workspace/executeCommand',
        \ {'command': 'decompile', 'arguments': [a:uri]})
  setlocal modifiable noreadonly
  silent %delete _
  call setline(1, split(get(l:res, 'code', ''), "\n"))
  setlocal buftype=nofile bufhidden=hide noswapfile nomodified readonly nomodifiable
  let &l:filetype = tolower(get(l:res, 'language', 'kotlin'))
endfunction
augroup vimrc_kotlin_lsp
  autocmd!
  autocmd BufReadCmd jar://* call s:KotlinLspDecompile(expand('<amatch>'))
augroup END

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F1> :call ToggleQuickFix()<cr>

" Eclipse-style semantic highlighting (coc semantic tokens, enabled for kotlin in
" coc-settings.json). Groups are CocSemType<Type> and CocSemTypeMod<Type><FirstModifier>;
" inspect the token under the cursor with :CocCommand semanticTokens.inspect
" Fields blue, constants bold italic, abstract/interface italic, declarations bold.
" Base and modifier groups overlap and vim merges their attributes, so only put
" attributes on a base group when every modifier variant should have them too.
let s:semantic_highlights = [
      \ ['Property',                 'GruvboxBlue',   ''],
      \ ['ModPropertyAbstract',      'GruvboxBlue',   'italic'],
      \ ['ModPropertyStatic',        'GruvboxBlue',   'italic'],
      \ ['EnumMember',               'GruvboxBlue',   'bold,italic'],
      \ ['Variable',                 'GruvboxFg1',    ''],
      \ ['Parameter',                'GruvboxOrange', ''],
      \ ['Class',                    'GruvboxYellow', ''],
      \ ['ModClassDeclaration',      'GruvboxYellow', 'bold'],
      \ ['ModClassAbstract',         'GruvboxYellow', 'italic'],
      \ ['Interface',                'GruvboxYellow', 'italic'],
      \ ['ModInterfaceDeclaration',  'GruvboxYellow', 'bold,italic'],
      \ ['Enum',                     'GruvboxYellow', ''],
      \ ['ModEnumDeclaration',       'GruvboxYellow', 'bold'],
      \ ['Struct',                   'GruvboxYellow', ''],
      \ ['ModStructDeclaration',     'GruvboxYellow', 'bold'],
      \ ['Type',                     'GruvboxYellow', ''],
      \ ['TypeParameter',            'GruvboxYellow', 'bold'],
      \ ['Method',                   'GruvboxGreen',  ''],
      \ ['ModMethodDeclaration',     'GruvboxGreen',  'bold'],
      \ ['ModMethodAbstract',        'GruvboxGreen',  'italic'],
      \ ['ModMethodStatic',          'GruvboxGreen',  'italic'],
      \ ['Function',                 'GruvboxGreen',  ''],
      \ ['ModFunctionDeclaration',   'GruvboxGreen',  'bold'],
      \ ['Decorator',                'GruvboxFg4',    ''],
      \ ]

" Copy the foreground of a colorscheme group and add attributes (bold/italic/...).
function! s:SemanticHighlight(name, from, attrs) abort
  let l:group = 'CocSemType' . a:name
  let l:id = synIDtrans(hlID(a:from))
  let l:cmd = 'highlight ' . l:group
  for l:mode in ['cterm', 'gui']
    let l:fg = synIDattr(l:id, 'fg', l:mode)
    if !empty(l:fg)
      let l:cmd .= ' ' . l:mode . 'fg=' . l:fg
    endif
    let l:cmd .= ' ' . l:mode . '=' . (empty(a:attrs) ? 'NONE' : a:attrs)
  endfor
  execute 'highlight clear ' . l:group
  execute l:cmd
endfunction

" Every modifier group defaults to its base type's look; explicit 'Mod...' entries
" above override it. Without this, coc creates empty modifier groups that blank
" out the base color. Deprecated keeps coc's strikethrough.
let s:semantic_modifiers = ['Declaration', 'Definition', 'Readonly', 'Static', 'Abstract',
      \ 'Async', 'Modification', 'Documentation', 'DefaultLibrary']

function! s:ApplySemanticHighlights() abort
  for [l:name, l:from, l:attrs] in s:semantic_highlights
    if l:name !~# '^Mod'
      call s:SemanticHighlight(l:name, l:from, l:attrs)
      for l:modifier in s:semantic_modifiers
        call s:SemanticHighlight('Mod' . l:name . l:modifier, l:from, l:attrs)
      endfor
    endif
  endfor
  for [l:name, l:from, l:attrs] in s:semantic_highlights
    if l:name =~# '^Mod'
      call s:SemanticHighlight(l:name, l:from, l:attrs)
    endif
  endfor
endfunction

augroup vimrc_semantic_highlights
  autocmd!
  autocmd ColorScheme * call s:ApplySemanticHighlights()
augroup END

" italics / strikethrough escape codes (xterm-256color terminfo on macOS lacks them)
if !has('gui_running')
  let &t_ZH = "\e[3m"
  let &t_ZR = "\e[23m"
  let &t_Ts = "\e[9m"
  let &t_Te = "\e[29m"
endif

set background=dark
colors gruvbox
