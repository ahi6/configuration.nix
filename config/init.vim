" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Set the tab width to 4 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Enable mouse support
set mouse=a

" Set the color scheme
"colorscheme morning
colorscheme wildcharm
"highlight MatchParen cterm=bold ctermbg=NONE ctermfg=magenta guibg=LightYellow guifg=Black
highlight MatchParen cterm=bold ctermbg=NONE ctermfg=magenta guibg=magenta guifg=Black

" Haskell options
let hs_highlight_delimiters = 1
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1
let hs_highlight_debug = 1
