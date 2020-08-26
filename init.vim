:" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"   This is to verify shell script
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'francoiscabrol/ranger.vim'
Plug 'airblade/vim-rooter'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'zxqfl/tabnine-vim'
Plug 'vim-airline/vim-airline'
"Plug 'ap/vim-buftabline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
" Initialize plugin system
call plug#end()
" Mappings +++++++++++++++++++++++++++++++++++++++
let mapleader = ","
map <f8> <ESC>:bn<CR>
map <f7> <ESC>:bp<CR>
map ii <ESC> :w<CR>
imap ii <ESC> :w<CR>
map <silent> <C-n> :NERDTreeToggle<CR>
imap jj <ESC> :w !python3 % <CR>
set noswapfile
set hidden
set guifont=DroidSansMono\ Nerd\ Font\ 11
" nnoremap <C-m> :bnext<CR>
" nnoremap <C-p> :bprev<CR>
colorscheme gruvbox
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': [], 'python': ['black']}
let g:ale_fix_on_save = 1
let g:airline_theme='random'
let g:airline#extensions#tabline#enabled = 1
set relativenumber
set encoding=UTF-8
let g:airline_theme = 'base16_grayscale'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1
"This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :FloatermNew<CR>
"nnoremap <leader>t :FloatermNew --height=0.9 --width=0.7 --wintype=floating --name=floaterm1 --position=topright --autoclose=1 cd dark-crawler && bash dark-crawler.sh<CR>
nnoremap <leader>r :FloatermNew --height=0.7 --width=0.7 --wintype=floating --name=floaterm2 --position=topright --autoclose=2 ranger<CR>
nnoremap <leader>m :Marks<CR>
imap <leader>, :<esc>


" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
