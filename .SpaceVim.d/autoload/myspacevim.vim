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

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    " TODO: Telescope crashes if tried to open in NERDtree buffer.
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

    "
    " Telescope
    "
    call SpaceVim#custom#SPC('nnoremap', ['f', 'f'], '<cmd>Telescope find_files<cr>', 'Telescope: Find files', 1)
    call SpaceVim#custom#SPC('nnoremap', ['f', 'b'], '<cmd>Telescope buffers<cr>', 'Telescope: Find buffer', 1)


endfunction

function! myspacevim#after() abort

    "
    " Sneak
    "
    map s <Plug>Sneak_s
    map S <Plug>Sneak_S

  endfunction
