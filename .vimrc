"==========================================
" ProjectLink: https://github.com/zihuaVeryGood/vim_config
" Author:  zihua
" Version: 1.0
" BlogDescribe:[todo] anything write
" Last_modify: 2022-6-16
" Desc: vim config for server, without any plugins.
" Reference: 
"   - https://github.com/wklken/vim-for-server
"   - https://github.com/preservim/nerdtree
"   - https://github.com/morhetz/gruvbox 
"==========================================



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader
let mapleader = ','
let g:mapleader = ','

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500
set tw=0                        " set 'textwidth'

set clipboard=unnamed           " used upnamed clipboard

" show location
set cursorcolumn
set cursorline

" movement
set scrolloff=7                 " keep 3 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
" set relativenumber              " show line relative
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=indent
set foldlevel=99
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present
exec "nohlsearch"

" toggle highlight search
let s:toggleHls = 1
map <F8> :call g:ToggleHLS()<CR> 
vmap <F8> :call g:ToggleHLS()<CR> 
imap <F8> :call g:ToggleHLS()<CR> 
fun! g:ToggleHLS()
    if s:toggleHls == 1
        set nohlsearch        
        let s:toggleHls = 0
    else
        set hlsearch
        let s:toggleHls = 1
    endif
endfun



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B



" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
" set mouse=a



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default status line and theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set default color scheme gruvbox.
autocmd VimEnter * call SetExistsGruvboox()                             " Scheme link: https://github.com/morhetz/gruvbox
function! SetExistsGruvboox() abort
    let s:schemes = map(globpath(&runtimepath, "colors/*.vim", 0, 1), 'fnamemodify(v:val, ":t:r")')
    if index(s:schemes, "gruvbox") >= 0
        colorscheme gruvbox
        set background=dark
    else
        colorscheme ron
    endif
endfunc

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Specific file type auto start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
" issue: Error trigger 'BufRead' and 'BufNew': Type <TAB> at the beginning of the paragraph will trigger subsequent code.
" autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py,*.awk exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    " awk
    if &filetype == 'awk'
        echo "awk"
        call setline(1, "\#!/usr/bin/awk -f")
    endif

    normal G
    normal o
    normal o
endfunc

" autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
" fun! <SID>StripTrailingWhitespaces()
"     let l = line(".")
"     let c = col(".")
"     %s/\s\+$//e:
"     call cursor(l, c)
" endfun


" set notekey before new file and new buffer.
autocmd BufNewFile *.c,*.cpp,*.java,*.go,*.vimrc,*.sh exec ":call AutoSetNotekey()"
autocmd BufEnter *.c,*.cpp,*.java,*.go,*.vimrc,*.sh exec ":call AutoSetNotekey()" 
autocmd FileType *.c,*.cpp,*.java,*.go,*.vimrc,*.sh exec ":call AutoSetNotekey()"
function! AutoSetNotekey()
    " .sh
    if &filetype == 'sh'
        call g:note.SetNoteKey("#")
    endif

    " .c .cpp .java .go
    if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java' || &filetype == 'go'
        call g:note.SetNoteKey("//")
    endif

    " .vimrc
    if &filetype == 'vim'
        call g:note.SetNoteKey("\"")
    endif
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>t :term<CR>


  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab page
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>w :tabnew<CR>
noremap <Leader>n :tabnext<CR>
noremap <Leader>p :tabprevious<CR>
noremap <Leader>q :tabclose<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extended keymap setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <C-d> <ESC>ddi

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

noremap <C-W-Up> <C-W>k
noremap <C-W-Down> <C-W>j
noremap <C-W-Left> <C-W>h
noremap <C-W-Right> <C-W>l

nnoremap <F2> :set rnu! nu!<CR>
noremap <F5> :set nonu nornu<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented
au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" kj replace Esc
inoremap kj <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" switch # *
" nnoremap # *
" nnoremap * #

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

"Map ; to : and save a million keystrokes
" ex mode commands made easy 用于快速进入命令行
nnoremap ; :

" Shift+H goto head of the line, Shift+L goto end of the line
nnoremap H 0^
nnoremap L $

" save on only-read file
cmap w!! w !sudo tee >/dev/null %

" command mode, ctrl-a to head， ctrl-e to tail
" cnoremap <C-j> <t_kd>
" cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" todo : 2022/6/18
" within command mode, ctrl+k delete to tail.ctrl+u delete to head
" cnoremap <C-K>
" cnoremap <C-U>
command! -nargs=0 SetPosHead call SetPosHead()
function! SetPosHead() abort
    echo "cmd pos:" . getcmdpos() 
endfunc

" J movo down 5 line, K move up 5 line.
noremap J 5j
noremap K 5k
map <Leader>j 5j
map <Leader>k 5k

" reload user vimrc
map R :source ~/.vimrc<CR>

" quick save or quite
map S :w<CR>
map Q :q<CR>
map WQ :wq<CR>


" Within normal mode, <TAB> quick install a tab character in head
" bugs: if mapping <TAB> that will disable the jump-back(<C-O>) or jump-forword(<C-I>)
" map <TAB> ma0i<TAB><ESC>'a
" map <S-TAB> :call BackTab()<CR>
function! BackTab() abort
    let tabwidth = 0
    if &shiftwidth == 0
        let tabwidth = &tabstop
    else
        let tabwidth = &shiftwidth
    endif

    let line = getline(".")
    if len(line) >= tabwidth
        let i = 0
        let flag = 1
        while i < tabwidth
            if line[i] != " "
                let flag = 0
                break
            endif
            let i += 1
        endwhile

        if flag == 1
            execute "normal! ma0xxxx'a"
        endif
    endif
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart symbol indent and match pairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap ( ()<ESC>i
inoremap ) <ESC>:call RemoveNextRepeatChar(")")<CR>a
inoremap [ []<ESC>i
inoremap ] <ESC>:call RemoveNextRepeatChar("]")<CR>a
" inoremap { {}<ESC>i
" inoremap } <ESC>:call RemoveNextRepeatChar("}")<CR>a

" Needs improvement
inoremap {<CR> {<ESC>o}<ESC><<O
inoremap <Silent><BS> <ESC>:call RemovePairs()<CR>a
" todo auto complet character '(' '[' '{'
" inoremap <CR> <ESC>:call AutoCompletChar()<CR>

function! RemovePairs() abort
    let line = getline(".")
    let prev = line[col(".")-1]
    let dict = ["(", "[", "{", "\"", "\'"]
    let pairs = { "(": ")", "[": "]", "{": "}", "\"": "\"", "\'": "\'" }

    if index(dict, prev) != -1
        if line[col(".")] == pairs[prev] 
            execute "normal! v%xa"
        else
            execute "normal! a\<BS>"
        endif
    else
        execute "normal! a\<BS>"
    endif
endfunc

" issue#: if "()" in first word, go to head front and press ")", the ")" can not create.
function! RemoveNextRepeatChar(ch) abort
    let line = getline(".")
    let next = line[col(".")]

    if a:ch == next
        execute "normal! l"
    else
        execute "normal! a" . a:ch . ""
    endif
endfunc

function! AutoCompletChar() abort
    let dict = ["{", "[", "("]
    let pairs = { "{" : "}", "[": "]", "(": ")" }

    let prev = line[col(".")-1]

    if index(dict, prev) != -1
        let next = line[col(".")]
        let pair = pairs[prev]
        execute "normal! <CR>"
    endif
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows reisze 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" issue: can not mapping <Alt+...>
noremap <A-j> :m.+1<CR>==
noremap <A-k> :m.-2<CR>==
inoremap <A-j> <ESC>:m.+1<CR>==gi
inoremap <A-k> <ESC>:m.-2<CR>==gi
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m'>-2<CR>gv=gv

" sub window resize
noremap <S-Up> :resize -3<CR>
noremap <S-Down> :resize +3<CR>
noremap <S-Left> :vertical resize -3<CR>
noremap <S-Right> :vertical resize +3<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment configure start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is global notekey, you can call SetNoteKey() to update it.

let g:note = {}
let g:note.noteKey = "\""

" If [g:ignoreNote != 0], the commented lines are ignored when commenting. 
let g:note.ignoreNote = 0

command! -nargs=0 Normalsetcomment call g:note.NormalSetOrCancelNote()
command! -nargs=0 Visualsetcomment call g:note.VisualSetOrCancelNote()

" vmap <C-L> 0I" <ESC> 
map <C-m>  :Normalsetcomment<CR>
vmap <C-m> <ESC>:Visualsetcomment<CR>

" note line for normal mode
function! g:note.NormalSetOrCancelNote() abort
    let lineNum = line(".")
    let linestr = getline(lineNum)
    let hasNote = g:note.HasNote(linestr)

    if g:note.ignoreNote == 0 
        if hasNote[0] == 1
            let pos = [0, lineNum, hasNote[1] + 1, 0]
            call setpos(".", pos)

            let i = 0
            while i < len(g:note.noteKey)
                execute "normal! x"
                let i = i + 1
            endwhile

            " delete the space character
            if len(g:note.noteKey) + 1 <= len(linestr) && linestr[hasNote[1] + len(g:note.noteKey)] == " "
                execute "normal! x"
            endif
        else 
            execute "normal! 0i" . g:note.noteKey . " \<ESC>"
        endif
    else
        let flag = 0
        let i = 0
        while  i < len(g:note.noteKey)
            if linestr[i] != g:note.noteKey[i]
                let flag = 1
                break
            endif
            let i = i + 1 
        endwhile

        if flag == 1
            execute "normal! 0i" . g:note.noteKey . " \<ESC>"
        else
            let i = 0
            while i < len(g:note.noteKey)
                execute "normal! 0x"
                let i = i + 1
            endwhile
            execute "normal! x"
        endif
    endif
endfunc

" note line for visual mode
function! g:note.VisualSetOrCancelNote() abort
    let [col1, row1] = getpos("'<")[1:2]
    let [col2, row2] = getpos("'>")[1:2]
    let lines = getline(col1, col2)

    " call cursor to first line
    call setpos(".", [0, col1, 0, 0])

    let i = col1
    while i <= col2
        call g:note.NormalSetOrCancelNote() 
        if i != col2
            execute "normal! j"
        endif
        let i = i + 1 
    endwhile

    execute "normal! gv"
endfunc

" ret[0] 0 means no comment
" ret[1] sub index of the text to be comment
function! g:note.HasNote(str) abort
    let ret = [0, 0]
    let len = len(a:str)

    let i = 0
    while i < len
        if !(a:str[i] == " " || a:str[i] == "\t")
            let lenNoteKey = len(g:note.noteKey)
            if len - i >= lenNoteKey
                let j = i
                let flag = 1
                while j <= i + lenNoteKey - 1
                    if a:str[j] != g:note.noteKey[j - i]
                        let flag = 0
                        break
                    endif
                    let j = j + 1
                endwhile

                if flag == 1
                    let ret = [1, i]
                else
                    let ret = [0, 0]
                endif
            else
                let ret = [1, i]
            endif

            break
        endif
        let i = i + 1
    endwhile

    return ret
endfunc

" command [SetNoteKey] will set global varibale [g:noteKey], thus replcing the comment item 
command! -nargs=1 -complete=customlist,SetNoteKeyAutoComplet SetNoteKey call g:note.SetNoteKey("<args>")
function! g:note.SetNoteKey(key) abort
    if len(a:key) != 0 && a:key[0] != " "
        let g:note.noteKey = a:key
    endif
endfunc
function! SetNoteKeyAutoComplet(ArgLead, CmdLine, CusorPos) abort
    return ["#", "\"", "//"]
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Block selected
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap vv :call BlockSelected()<CR> 
function! BlockSelected() abort
    let c = col(".")
    let sline = getline(".")
    if c > 1 && sline[c-2] != " " && sline[c-2] != "\t"
        execute "normal! b"
    endif

    " I don't konw why append 'h'.The result will move right 1 word when used [vv] to execute 'bve'.
    execute "normal! veh" 
endfunc

" Press <Leader> + [anykey] visual mode quick insert both sides selected word.
vnoremap <leader>" :call BothSidersInstallInVisualmode("\"")<CR>
function! BothSidersInstallInVisualmode(key) abort 
    let [col1, row1] = getpos("'<")[1:2]
    let [col2, row2] = getpos("'>")[1:2]

    call setpos(".", [0, col1, row1, 0])
    execute "normal! i" . a:key . "\<ESC>"

    call setpos(".", [0, col2, row2, 0])
    execute "normal! a" . a:key . "\<ESC>"

    execute "normal! gv"
endfunc

" Within visual mode, <leader>+p will replace text in cliboard
vnoremap <leader>p d:call BlockReplace()<CR> 
function! BlockReplace() abort
    let clicontext = @0
    execute "normal! i" . clicontext . "\<ESC>" 
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configure
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:complete_current = "coc.nvim"
if !empty(glob("~/.vim/autoload/plug.vim"))
    call plug#begin()
        Plug 'morhetz/gruvbox'
        Plug 'preservim/nerdtree'
        Plug 'mhinz/vim-startify'
        Plug 'skywind3000/vim-auto-popmenu'
        Plug 'skywind3000/vim-dict'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    call plug#end()

    " NERDTree setting
    autocmd VimEnter * NERDTree                                         " Start NERDTree and leave the cursor in it.
    autocmd VimEnter * NERDTree | wincmd p                              " Start NERDTree and put the cursor back in the other window.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
        \ quit | endif                                                  " Exit Vim if NERDTree is the only window remaining in the only tab.

    autocmd StdinReadPre * let s:std_in=1                               " Start NERDTree when Vim starts with a directory argument.
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " NERDTree mapping configure.
"     noremap <C-n> :NERDTree<CR>
    noremap <C-t> :NERDTreeToggle<CR>
    noremap <C-f> :NERDTreeFocus<CR>
    noremap <C-p> :NERDTreeFind<CR>


    " ============================ coc.nvim configure start ===========================
    if g:complete_current == "coc.nvim"
        let g:coc_global_extensions = [ 
                    \ 'coc-sh', 'coc-go', 'coc-json', 'coc-tsserver', 'coc-vimlsp', 'coc-snippets'
                    \ ]          " coc auto install extensions.

        set nobackup
        set nowritebackup
        set updatetime=100
        set signcolumn=yes

        " Use tab for trigger completion with characters ahead and navigate.
        inoremap <silent><expr> <TAB>
                    \ coc#pum#visible() ? coc#pum#next(1) :
                    \ CheckBackspace() ? "\<Tab>" :
                    \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        function! CheckBackspace() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Make <CR> to accept selected completion item or notify coc.nvim to format
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        " Use <c-space> to trigger completion.
        if has('nvim')
            inoremap <silent><expr> <c-space> coc#refresh()
        else
            inoremap <silent><expr> <c-@> coc#refresh()
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use <C-h> to show documentation in preview window.
        nnoremap <silent> <F1>  :call <SID>show_documentation()<CR>
        function! s:show_documentation()
            if (index(['vim', 'help'], &filetype) >= 0)
                execute 'h ' . expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Symbol renaming.
        nmap <Leader>r <Plug>(coc-rename)

        " coc-snippets setting
        let g:coc_snippet_next = '<tab>'
    endif
    " ============================ coc.nvim configure end ===========================
    
    " configure airline
    let g:airline_theme = 'sol'   " minimalist, 
"     let g:airline#extensions#tabline#enabled = 1
"     let g:airline#extensions#tabline#left_sep = ' '
"     let g:airline#extensions#tabline#left_alt_sep = '|'
"     let g:airline#extensions#tabline#formatter = 'default'

    " vim-auto-popmenu configure
    " Note: If have else complete plugin, disable apc.
    if g:complete_current == "apc"
        let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1, 'c':1, 'cpp':1, 'cmake':1, 'golang':1, 'html':1, 'java':1, 'javascript':1, 'latex':1, 'lua':1, 'make':1, 'node':1, 'python':1, 'ruby':1, 'rust':1, 'scala':1, 'sh':1, 'verilog':1, 'vim':1, 'wiki':1, 'word':1, 'xhtml':1, 'zsh':1}               
                                                                            " Enable popmenu for filetypes, '*' for all files.
        set cpt=.,k,w,b                                                     " Source for dictionary, current or other loaded buffers, see ':h cpt'
        set completeopt=menu,menuone,noselect                               " Don't select the first item.
        set shortmess+=c                                                    " Suppress annoy messages.
    endif
else
"   Please download plug.vim manually then [:PlugInstall] after Re-enter Vim and input [:PlugInstall] command.
"     silent exec "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>&1 >/dev/null"
"     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" todo[nano]: The same as nano prompt action bar 
" todo: integrating gdb

