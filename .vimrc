"Use Pathogen if exists
try
  execute pathogen#infect()
catch
endtry

""""""""""""""""""""""""""""""""""
" Syntax and indent
""""""""""""""""""""""""""""""""""
syntax on " Turn on syntax highligthing
set showmatch  "Show matching bracets when text indicator is over them

colorscheme ansi_blows

" Switch on filetype detection and loads
" indent file (indent.vim) for specific file types
filetype indent on
filetype on
set autoindent " Copy indent from the row above
set si " Smart indent

" set delete as backspace
set backspace=indent,eol,start

""""""""""""""""""""""
" Status line
""""""""""""""""""""""
" always show filename in status bar
set laststatus=2


""""""""""""""""""""""""""""""""""
" Some other confy settings
""""""""""""""""""""""""""""""""""
" set nu " Number lines
set hls " highlight search
set lbr " linebreak

" Use 2 space instead of tab during format
set expandtab
set shiftwidth=2
set softtabstop=2

" Show line numbers
set number

"paste toggle of F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" big history
set history=1000

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" auto remove whitespace from certain files
autocmd BufWritePre *.scala,*.rb,*.yml,*.java,*.csv,*.js,*.json :%s/\s\+$//e

" autosort scala imports
autocmd Filetype scala SortScalaImports
autocmd BufWritePre *.scala :SortScalaImports

" spellchecking for git commits
autocmd FileType gitcommit setlocal spell

" specify comment types for some filetypes
autocmd FileType scala set commentstring=//\ %s
autocmd FileType ruby set commentstring=#\ %s

highlight SignColumn ctermbg=black guibg=black

" Markdown language highlighting
let g:markdown_fenced_languages = ['java', 'scala']

"use https://github.com/ggreer/the_silver_searcher instead of ack in the ack plugin, if exists
try
  let g:ackprg = 'ag --vimgrep'
catch
endtry

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff},%{fugitive#statusline()}]%h%m%r%y%=%c,%l/%L\ %P
