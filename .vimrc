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

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" auto remove whitespace from certain files
autocmd BufWritePre *.scala,*.rb,*.yml,*.java,*.csv,*.js,*.json :%s/\s\+$//e

autocmd FileType gitcommit setlocal spell
autocmd FileType scala set commentstring=//\ %s
autocmd FileType ruby set commentstring=#\ %s

highlight SignColumn ctermbg=black guibg=black
