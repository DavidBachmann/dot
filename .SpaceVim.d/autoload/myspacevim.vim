function! myspacevim#before() abort
    syntax on
    set termguicolors
    set guifont=Hack\ Nerd\ Font\ Mono:h16

    " Configure neovide, in case we're using it
    let g:neovide_refresh_rate=60
    let g:neovide_fullscreen=v:false
    let g:neovide_cursor_vfx_mode = "pixiedust"

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
  let g:neoformat_enabled_javascript = ['prettier']
  let g:neoformat_enabled_typescript = ['prettier']
  let g:neoformat_enabled_javascriptreact = ['prettier']
  let g:neoformat_enabled_typescriptreact = ['prettier']


  "
  " Sneak
  "
  map s <Plug>Sneak_s
  map S <Plug>Sneak_S

  " React TSX colors

  hi tsxTagName guifg=#E06C75
  hi tsxCloseTagName guifg=#E06C75
  hi tsxComponentName guifg=#E06C75
  hi tsxCloseComponentName guifg=#E06C75

  hi tsxCloseString guifg=#F99575
  hi tsxAttributeBraces guifg=#F99575
  hi tsxEqual guifg=#F99575

  hi tsxAttrib guifg=#F8BD7F cterm=italic

  hi tsxTypeBraces guifg=#999999

  hi tsxTypes guifg=#666666

  hi ReactState guifg=#C176A7
  hi ReactProps guifg=#D19A66
  hi Events ctermfg=204 guifg=#56B6C2
  hi WebBrowser ctermfg=204 guifg=#56B6C2
  hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66


endfunction
