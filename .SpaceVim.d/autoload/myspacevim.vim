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
    set omnifunc=syntaxcomplete#Complete


    " Configure the gruvbox theme
    let g:gruvbox_contrast_dark = 'hard'

    " Show dotfiles in NERDTree
    let NERDTreeShowHidden=1

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

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

    " Turn off highlighted search
    nnoremap <esc> :nohlsearch<cr><esc>

    call SpaceVim#custom#SPC('nnoremap', ['f', 'z'], '<cmd>FZF<CR>', 'FZF', 1)


endfunction

function! myspacevim#after() abort

    "
    " eslint via Neomake
    "

    let g:neomake_typescript_eslint_maker =  {
      \ 'exe': 'npx',
      \ 'args': ['--quiet', 'eslint', '--format=compact'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
      \ 'cwd': '%:p:h',
      \ 'output_stream': 'stdout',
      \ }

    let g:neomake_javascript_eslint_maker =  {
      \ 'exe': 'npx',
      \ 'args': ['--quiet', 'eslint', '--format=compact'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
      \ 'cwd': '%:p:h',
      \ 'output_stream': 'stdout',
      \ }

    let g:neoformat_enabled_javascript = ['prettier']
    let g:neoformat_enabled_typescript = ['prettier']
    let g:neomake_javascript_jsx_enabled_makers = ['eslint']
    let g:neomake_typescript_enabled_makers = ['eslint', 'tsc']

    " Fix vim throwing E523 Not Allowed Here when using Telescope to open files.
    let g:deoplete#enable_at_startup = 0

    "
    " Sneak
    "
    map s <Plug>Sneak_s
    map S <Plug>Sneak_S

  endfunction
