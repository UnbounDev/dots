
" -- plugins --
" - For Neovim: ~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vimwiki/vimwiki'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'terryma/vim-multiple-cursors'

Plug 'yuttie/comfortable-motion.vim'

" Plug 'valloric/youcompleteme'

Plug 'arcticicestudio/nord-vim'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
"Plug 'quramy/tsuquyomi'

call plug#end()

" -- set defaults --

" - theme
" syntax enable
" set background=dark
let g:airline_theme='lucius'
" let g:airline_solarized_bg='dark'
" colorscheme solarized

set cursorline                                    " to easily see which line your cursor is on
set autochdir                                     " synchronize vim's cwd with the cwd of the current
set ignorecase                                    " ignore case in search patterns
set virtualedit=onemore                           " navigate to the true end of the line
set timeout timeoutlen=300 ttimeoutlen=25        " timeout for binding sequences
set nu                                            " line numbers
" set laststatus=2                                  " always show status line
set backspace=2                                   " backspace legit
set mouse-=a                                      " disable mouse usage

" word wrapping
" set linebreak                                     " perform linebreak at word boundary
" set wrap                                          " enable line wrapping
" set cc=+2                                         " highlight 1 column past tw
" set tw=100                                        " ? it's a thing
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey  " change highlight color 

set nolist                                        " list disables linebreak
set nu                                           " relative numbered lines
" set title                                         " display filename in the title
set undolevels=20                                 " levels of undo ;)
set noerrorbells                                  " fthatshit
set noswapfile                                    " save often don't worry about messy garbage
set nobackup                                      " ditto

let g:is_posix = 1                                " use proper syntax highlighting for shell scripts
let g:indentLine_enabled = 1                      " show indent line for quick spacing adjustments
let g:indentLine_char = "⟩"                       " ditto
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
let NoMatchParen=1                                " don't lighlight matching parens

" airline settings
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
set laststatus=2

" ctrlp settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" -- tab styles --
set modeline
set tabstop=2 softtabstop=2 expandtab shiftwidth=2
autocmd Filetype python setlocal tabstop=8 expandtab! shiftwidth=8 softtabstop=8
inoremap <m-Tab> <c-v><tab>

" -- vimiwiki settings --
let g:vimwiki_list = [{'path': '~/vimwiki/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

" -- key mappings --

" - easier pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" - trigger ctrlp plugin
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>t :CtrlP<CR>

