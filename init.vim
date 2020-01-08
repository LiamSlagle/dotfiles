" basics
set number relativenumber
set splitright
set splitbelow
set undolevels=1000
set undoreload=10000
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set autoindent
set nowrap
set incsearch
set ignorecase
set smartcase

" basic shortcut remaps
nmap ; :
nmap 0 0w
vnoremap < <gv
vnoremap > >gv
nmap <C-J>  i<CR><Esc>
nmap <C-w><C-w> <C-w>_<C-w><bar> # double press C-w to fully expand pand

" filetypes
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
autocmd BufRead,BufNewFile *.ts set filetype=typescript.tsx

" easymotion/easyalign
map <space> <Plug>(easymotion-prefix)
map <space>s <Plug>(easymotion-sn)
nmap ga <Plug>(LiveEasyAlign)
xmap ga <Plug>(LiveEasyAlign)

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
nmap F :Files<CR>
nmap B :Buffer<CR>
nmap R :Rg<CR>
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': []}), <bang>0)

" slimux
let g:test#custom_strategies = {'slimux': function('SlimuxStrategy')}
let g:test#strategy = 'slimux'
nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>s :TestNearest<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>T :TestVisit<CR>
function! SlimuxStrategy(cmd)
  execute 'SlimuxShellRun ' . 'clear && ' . a:cmd
endfunction

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
nmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
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
let g:airline_section_b = '%{strftime("%H:%M")}'
let g:deoplete#enable_at_startup = 1

" plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'matze/vim-move'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'epeli/slimux'
Plug 'janko-m/vim-test'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', { 'tag': '*', 'branch': 'release' }
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'iCyMind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" colors
colorscheme NeoSolarized
set background=dark
hi Normal guibg=NONE ctermbg=NONE
set hlsearch               " Highlight search terms
set colorcolumn=80         " Hightlight column 80 for manual wrapping
highlight SpecialKey ctermfg=darkred guifg=darkred ctermbg=NONE guibg=NONE
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
