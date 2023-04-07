" basics
set number relativenumber
set splitright
set splitbelow
set undolevels=1000
set undoreload=10000
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set winminheight=0
set autoindent
set nowrap
set incsearch
set ignorecase
set smartcase
set hidden
set mouse=a
set guifont=DroidSansMono_Nerd_Font:h11

" basic shortcut remaps
nmap ; :
nmap 0 0w
vnoremap < <gv
vnoremap > >gv
nmap <C-w><C-w> <C-w>_<C-w><bar> # double press C-w to fully expand pane

" buffer delete
command! BufferDeleteAll %bd
nmap L :BufferDeleteAll<CR><C-o>

" split line
nmap <C-j> i<CR><Esc>

" clear highlights
nmap H :noh<CR>

" search
nmap D /

" svelte
let g:svelte_preprocessors = ['typescript']

" filetypes
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
autocmd BufRead,BufNewFile *.jsx set filetype=javascript

" easymotion/easyalign
map <space> <Plug>(easymotion-prefix)
map <space>s <Plug>(easymotion-sn)
nmap ga <Plug>(LiveEasyAlign)
xmap ga <Plug>(LiveEasyAlign)
let g:move_key_modifier = 'A'

" coc-pairs enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" fzf
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
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1 } }
"nmap F :Files<CR>
"nmap B :Buffer<CR>
"nmap R :Rg<CR>
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

" telescope
nnoremap F :Telescope find_files<CR>
nnoremap R :Telescope grep_string search="" only_sort_text=true<CR>
nnoremap B :Telescope buffers<CR>

" NERDTree
nnoremap <silent> <expr> <C-t> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : "\:NERDTree<CR>"
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" slimux
nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>s :TestNearest<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>T :TestVisit<CR>
function! SlimuxStrategy(cmd)
  execute 'SlimuxShellRun ' . 'clear && ' . a:cmd
endfunction
let g:test#custom_strategies = {'slimux': function('SlimuxStrategy')}
let g:test#strategy = 'slimux'

" ale
let g:ale_echo_msg_format = '[%linter%]% [code] %severity%: %%s'
let g:ale_fixers = {
  \'ruby': ['rubocop'],
  \}
nmap <silent> <F2> <Plug>(ale_next_wrap)
nmap <silent> <F3> <Plug>(ale_detail)
nmap <silent> gaf <Plug>(ale_fix)

" coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
xmap <leader>f <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)
nmap <silent> gca  <Plug>(coc-codeaction)
nmap qf  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" airline
"let g:airline_section_b = '%{strftime("%H:%M")}'
"let g:airline_theme = 'onehalfdark'

let g:yats_host_keyword = 1

" plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'

Plug 'easymotion/vim-easymotion'
Plug 'matze/vim-move'
Plug 'yonchu/accelerated-smooth-scroll'

Plug 'epeli/slimux'
Plug 'janko-m/vim-test'

Plug 'leafgarland/typescript-vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'sheerun/vim-polyglot'
Plug 'mxw/vim-jsx'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'dart-lang/dart-vim-plugin'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'marko-cerovac/material.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next
      },
    },
    file_ignore_patterns = { "yarn.lock", "node_modules" }
  },
}
EOF

lua << END
require('lualine').setup()
END

autocmd VimEnter,ColorScheme * hi! link CocMenuSel PMenuSel
autocmd VimEnter,ColorScheme * hi! link CocSearch Identifier

" colors
let g:material_style = 'deep ocean'
let g:material_italic_comments = v:true
let g:material_italic_keywords = v:true
let g:material_italic_functions = v:true
let g:material_contrast = v:false

set termguicolors
syntax on
set t_Co=256
set cursorline
colorscheme material
let g:indentLine_char = '|'
hi Norma guibg=NONE ctermbg=NONE
set hlsearch               " Highlight search terms
set colorcolumn=80         " Hightlight column 80 for manual wrapping
highlight SpecialKey ctermfg=darkred guifg=darkred ctermbg=NONE guibg=NONE
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
