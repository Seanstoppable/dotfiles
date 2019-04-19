call plug#begin('~/.vim/plugged')

"Used often
"templates
Plug 'mrtazz/vim-stencil'
"Git tags in left hand side
Plug 'airblade/vim-gitgutter'
"Always create directory path
Plug 'pbrisbin/vim-mkdir'
"Directory exploration
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Linting
Plug 'w0rp/ale'
"Other
Plug 'editorconfig/editorconfig-vim'
Plug '907th/vim-auto-save'

"Meaning to use more
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Languages
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'conorclifford/vim-apidoc'
Plug 'dag/vim-fish'
Plug 'derekwyatt/vim-scala'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'

"ctags support
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

" Experimental

"Register browsing
Plug 'dahu/vim-lotr'
"Tex language
Plug 'lervag/vimtex'
"General test framework
Plug 'janko-m/vim-test'
"Testing markdown previews
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'kannokanno/previm'
Plug 'reedes/vim-wordy'

call plug#end()

""""""""""""""""""""""""""""""""""
" Syntax and indent
""""""""""""""""""""""""""""""""""
syntax on " Turn on syntax highligthing
set showmatch  "Show matching bracets when text indicator is over them

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Don't hide double quotes in JSON syntax
let g:vim_json_syntax_conceal = 0

" Switch on filetype detection and loads
" indent file (indent.vim) for specific file types
filetype indent on
filetype on
set autoindent " Copy indent from the row above
set smartindent " Smart indent
" Use 2 space instead of tab during format
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" set delete as backspace
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""
" Some other confy settings
""""""""""""""""""""""""""""""""""
" set nu " Number lines
set hlsearch " highlight search
" Clear the search buffer when hitting return
"nnoremap <cr> :nohlsearch<cr>
set linebreak " linebreak

set wildmode=list:longest "make cmdline tab completion similar to bash
set wildmenu              "enable ctrl-n and ctrl-p to scroll thru matches

" Show line numbers
set number

"paste toggle of F2
nnoremap <Leader>p :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"clear extra stuff in left columns
map <Leader>cl :GitGutterDisable<CR>:set nonumber<CR>
map <Leader>sl :GitGutterEnable<CR>:set number<CR>

"easy make
map <Leader>m :make<CR>

"git stuff
"grabbed from https://github.com/ajh17/dotfiles/blob/master/.vimrc
nnoremap <leader>go :silent !tig<CR>:silent redraw!<CR>
nnoremap <leader>gb :silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>

"easy copy
map <leader><Space> :%y+<CR>

let g:NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" big history
set history=1000
set undofile
set undodir=~/.vim/undodir

"cycle windows/buffers
nnoremap <Leader>[ :bprevious<CR>
nnoremap <Leader>] :bnext<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <Tab> <C-W><C-W>
set splitbelow
set splitright

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" When open a new file remember the cursor position of the last editing
augroup autocmd
  autocmd!
  if has('autocmd')
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  endif
  "unless we are a git commit, in which case, start at the start
  autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  autocmd BufEnter TAG_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" auto remove whitespace from certain files
augroup whitespace
  autocmd!
  autocmd BufWritePre *.scala,*.rb,*.yml,*.java,*.csv,*.js,*.json :%s/\s\+$//e
augroup END

" autosort scala imports
"augroup sortscalaimports
"autocmd Filetype scala SortScalaImports
"autocmd BufWritePre *.scala :SortScalaImports
"augroup END

let g:easytags_suppress_ctags_warning = 1

" specify comment types for some filetypes
augroup commentstrings
  autocmd!
  autocmd FileType scala set commentstring=//\ %s
  autocmd FileType ruby set commentstring=#\ %s
  autocmd FileType vim set commentstring=\"\ %s
augroup END

au BufRead,BufNewFile *.cap set filetype=ruby

" Markdown language highlighting
let g:markdown_fenced_languages = ['java', 'scala']

"use https://github.com/ggreer/the_silver_searcher instead of ack in the ack plugin, if exists
try
  let g:ackprg = 'ag --vimgrep'
catch
endtry

""""""""""""""""""""""""""""""""""
" Styling
""""""""""""""""""""""""""""""""""
try
  colorscheme ansi_blows
catch
endtry
highlight SignColumn ctermbg=black guibg=black

""""""""""""""""""""""
" Status line
""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=*\[%n]\                           "buffernr
set statusline+=%F\                               "File path
set statusline+=%m                                "modified flag
set statusline+=%r                                "read only flag
set statusline+=%h                                "help buffer flag
set statusline+=%w                                "preview window flag
set statusline+=%y\                               "FileType
try
  set statusline+=%{fugitive#statusline()}\         "Git info if fugitive is installed
catch
endtry
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]\    "Encoding
"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
set statusline+=%=      "left/right separator
set statusline+=row:%l/%L\ (%03p%%)\              "Row
set statusline+=column:%v\                        "Column

if &shell =~# 'fish$'
  set shell=bash
endif

if has('nvim')
  nnoremap <leader>o :below 10sp term://$SHELL<cr>i
endif

let g:vim_markdown_preview_browser='Google Chrome'
let g:vim_markdown_preview_github=1

nnoremap <leader>t :TagbarToggle<CR>
"paste current date in yyyy-mm-dd format
nnoremap <leader>d "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>dd :%s/<<DATE>>/\=strftime("%Y-%m-%d")/g<CR>

nnoremap <leader>af :Stencil apidoc_field<CR>
nnoremap <leader>am :Stencil apidoc_model<CR>

nnoremap <leader>gm :0read !git sincetag<CR>

nnoremap <leader>ll :%s/^/'/g<bar>%s/$/',/g<CR>
nnoremap <leader>lldb :%s/^/('/g<bar>%s/$/'),/g<CR>

nnoremap <leader>q :let @/ = ""<CR>

" Netrw options
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -28
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'  " --> I want line numbers on the netrw buffer
nnoremap <silent> <leader>k :Lexplore<cr>

"auto source .vimrc on change
augroup source_vimrc
  autocmd!
  autocmd BufWritePost .vimrc,_vimrc,vimrc,.vimrc.local source ~/.vimrc
augroup END

function! NumberToggle()
  if(&relativenumber == 1 && &number == 1)
    set number
    set norelativenumber
  elseif (&number == 1 && &relativenumber == 0)
    set norelativenumber
    set nonumber
  else
    set number
    set relativenumber
  endif
endfunc

function! Distinct()
  :%!awk '\!_[$0]++'
endfunc

nnoremap <leader>l :call NumberToggle()<CR>

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

let g:StencilTemplatepath = '~/.dotfiles/vim/templates/'

if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" ALE linting events
set updatetime=1000
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {'cpp': ['clang-format']}
let g:ale_ruby_ruby_executable = '~/.asdf/shims/ruby'
augroup ale
  autocmd!
  autocmd CursorHold * call ale#Queue(0)
  autocmd CursorHoldI * call ale#Queue(0)
  autocmd InsertEnter * call ale#Queue(0)
  autocmd InsertLeave * call ale#Queue(0)
augroup END

nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

"default textwidth and then specific overrides
set textwidth=100
augroup indenting
  autocmd!
  autocmd BufRead,BufNewFile *.jade,*.pub,Dockerfile set textwidth=0
  autocmd BufRead,BufNewFile *.csv set textwidth=0
augroup END
set colorcolumn=+1
