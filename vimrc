call plug#begin('~/.vim/plugged')

"Used often

"Git tags in left hand side
Plug 'airblade/vim-gitgutter'
"Always create directory path
Plug 'pbrisbin/vim-mkdir'
"Directory exploration
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"Meaning to use more

Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Languages

Plug 'conorclifford/vim-apidoc'
Plug 'dag/vim-fish'
Plug 'derekwyatt/vim-scala'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'

" Experimental

Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
"Register browsing
Plug 'dahu/vim-lotr'
"Tex language
Plug 'lervag/vimtex'
"General test framework
Plug 'janko-m/vim-test'
"Testing markdown previews
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'kannokanno/previm'

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
set si " Smart indent
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
set hls " highlight search
" Clear the search buffer when hitting return
"nnoremap <cr> :nohlsearch<cr>
set lbr " linebreak

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

"git stuff
"grabbed from https://github.com/ajh17/dotfiles/blob/master/.vimrc
nnoremap <leader>go :silent !tig<CR>:silent redraw!<CR>
nnoremap <leader>gb :silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>

"easy copy
map <leader><Space> :%w !pbcopy<CR>

let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

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
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
endif
"unless we are a git commit, in which case, start at the start
autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" auto remove whitespace from certain files
autocmd BufWritePre *.scala,*.rb,*.yml,*.java,*.csv,*.js,*.json :%s/\s\+$//e

" autosort scala imports
"autocmd Filetype scala SortScalaImports
"autocmd BufWritePre *.scala :SortScalaImports

" spellchecking for git commits
autocmd FileType gitcommit setlocal spell

" specify comment types for some filetypes
autocmd FileType scala set commentstring=//\ %s
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType vim set commentstring=\"\ %s

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

let vim_markdown_preview_github=1

nnoremap <leader>t :TagbarToggle<CR>

"auto source .vimrc on change
augroup source_vimrc
  autocmd!
  autocmd BufWritePost .vimrc,_vimrc,vimrc,.vimrc.local source ~/.vimrc
augroup END

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

