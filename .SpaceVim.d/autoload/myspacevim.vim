function! myspacevim#before() abort
    syntax on
    set termguicolors

    " Leader is comma
    let g:mapleader = ','
  
    " Pressing tab switches windows
    nnoremap <tab> <C-w>w

    " Disable mouse
    set mouse=

    " Searches are case insensitive...
    set ignorecase
    " ... unless they contain at least one capital letter
    set smartcase

    filetype plugin on
    set omnifunc=ale#completion#OmniFunc


    " Configure the gruvbox theme
    let g:gruvbox_contrast_dark = 'hard'

    " Fix files with prettier, and then ESLint.
    let b:ale_fixers = ['prettier', 'eslint']

    " Show dotfiles in NERDTree
    let NERDTreeShowHidden=1

    " Make NERDTree find the currently focused file
    map <leader>r :NERDTreeFind<cr><C-w>p

    " Use leader to trigger camel case motion
    let g:camelcasemotion_key = '<leader>'

    " Activate luochen1990/rainbow
    let g:rainbow_active = 1
    " But disable it in NERDTree
    let g:rainbow_conf = {
      \ 'separately': {
      \   'nerdtree': 0,
      \ }
      \}

    " vim-closetag options
    let g:closetag_filenames = "*.html,*.jsx,*.ts,*.vue,*.tsx,*.xml"
    let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ }

    " Move lines up/down with alt+k and alt+j
    " For this to work in iTerm go to preferences->profiles->keys and change left
    " option key to Esc+
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv

    " Turn off highlighted search with esc
    nnoremap <esc> :nohlsearch<cr><esc>

    " Put FZF inside SpaceVim SPC-f menu
    call SpaceVim#custom#SPC('nnoremap', ['f', 'z'], '<cmd>FZF<CR>', 'FZF', 1)


endfunction

function! myspacevim#after() abort
  let g:neomake_javascript_jsx_enabled_makers = ['eslint']

  "
  " Sneak
  "
  map s <Plug>Sneak_s
  map S <Plug>Sneak_S

endfunction
