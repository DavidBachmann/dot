local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.guifont = "Hack Nerd Font Mono:h15"
-- Use , instead of leader for bkad/CamelCaseMotion
vim.g.camelcasemotion_key = ','
-- Close tags automatically
vim.g.closetag_filenames = '*.tsx,*.jsx,*.html'

-- We need an annoyingly long timeout for 'surround' movements
vim.o.timeoutlen = 800

-- Make sure Lightspeed's keymaps are set.
-- I had issues where native vim 'S' took over Lightspeed's.
vim.api.nvim_set_keymap('n', 's', '<Plug>Lightspeed_s', {})
vim.api.nvim_set_keymap('n', 'S', '<Plug>Lightspeed_S', {})

-- Neovide thinks I mean ∆ when I type A-j
vim.api.nvim_set_keymap('n', '∆', ":m .+1<CR>==", {})
vim.api.nvim_set_keymap('v', '∆', ":m '>+1<CR>gv=gv", {})

-- Neovide thinks I mean ˚ when I type A-k
vim.api.nvim_set_keymap('n', '˚', ':m .-2<CR>==', {})
vim.api.nvim_set_keymap('v', '˚', ":m '<-2<CR>gv=gv", {})

-- Disable mouse
vim.opt.mouse = ""

-- Prettier configuration
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettierd",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
    },
  },
}

-- here's an example to disable formatting in "tsserver"
lvim.lsp.on_attach_callback = function(client, _)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

lvim.builtin.dashboard.custom_header = {
"                                                           ",
"                                                           ",
" :::::::::  :::::::::  :::::::::::   ::::::::::: ::::::::  ",
" :+:    :+: :+:    :+:     :+:           :+:    :+:    :+: ",
" +:+    +:+ +:+    +:+     +:+           +:+    +:+        ",
" +#+    +:+ +#++:++#+      +#+           +#+    +#++:++#++ ",
" +#+    +#+ +#+    +#+     +#+           +#+           +#+ ",
" #+#    #+# #+#    #+# #+# #+#  #+#      #+#    #+#    #+# ",
" #########  #########   #####   ###  ########### ########  ",
"                                                           ",
"                                                           ",
}

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "punk"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
  ["<esc>"] = "<cmd>nohlsearch<cr>", -- Turn off highlight after search
  ["<Tab>"] = "<C-w>", -- Tab is the same as pressing ctrl-w
  ["<Tab><Tab>"] = "<C-w>w", -- ctrl-w-w
  ["ScrollWheelUp"] = "<Nop>", -- disable mouse scroll
  ["ScrollWheelDown"] = "<Nop>", -- disable mouse scroll
  ["<S-h>"] = "<cmd>BufferPrevious<cr>", -- Switch buffers
  ["<S-l>"] = "<cmd>BufferNext<cr>", -- Switch buffers
}

-- I actually need to type kj and jk on many occations :)
lvim.keys.insert_mode['jj'] = nil
lvim.keys.insert_mode['jk'] = nil
lvim.keys.insert_mode['kj'] = nil

-- I use J for joining liness
lvim.keys.visual_block_mode['J'] = nil

-- I like K for lsp.hover
lvim.keys.visual_block_mode['K'] = nil

-- Show filename and path in lualine
lvim.builtin.lualine.sections.lualine_b = {
  {
    'filename',
    file_status = true, -- displays file status (readonly status, modified status)
    path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
  }
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup = {
  view = {
    mappings = {
      custom_only = true, -- To remap one key you have to opt out of all defaults.
      list = { -- And then set them again.
        { key = {"<CR>", "o"}, cb = tree_cb("edit") },
        { key = "s",           cb = tree_cb("vsplit") },
        { key = "<C-t>",       cb = tree_cb("tabnew") },
        { key = "<",           cb = tree_cb("prev_sibling") },
        { key = ">",           cb = tree_cb("next_sibling") },
        { key = "P",           cb = tree_cb("parent_node") },
        { key = "<BS>",        cb = tree_cb("close_node") },
        { key = "<S-CR>",      cb = tree_cb("close_node") },
        { key = "K",           cb = tree_cb("first_sibling") },
        { key = "J",           cb = tree_cb("last_sibling") },
        { key = "I",           cb = tree_cb("toggle_ignored") },
        { key = "H",           cb = tree_cb("toggle_dotfiles") },
        { key = "R",           cb = tree_cb("refresh") },
        { key = "a",           cb = tree_cb("create") },
        { key = "d",           cb = tree_cb("remove") },
        { key = "r",           cb = tree_cb("rename") },
        { key = "<C-r>",       cb = tree_cb("full_rename") },
        { key = "x",           cb = tree_cb("cut") },
        { key = "c",           cb = tree_cb("copy") },
        { key = "p",           cb = tree_cb("paste") },
        { key = "y",           cb = tree_cb("copy_name") },
        { key = "Y",           cb = tree_cb("copy_path") },
        { key = "gy",          cb = tree_cb("copy_absolute_path") },
        { key = "-",           cb = tree_cb("dir_up") },
        { key = "q",           cb = tree_cb("close") },
        { key = "g?",          cb = tree_cb("toggle_help") },
      }
    }
  },
  update_focused_file = {
    enable = true
  }
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
lvim.builtin.treesitter.ensure_installed = "maintained"

-- Configure builtin plugins
lvim.builtin.terminal.active = true

--lvim.lsp.diagnostics.virtual_text = true

-- Additional Plugins
lvim.plugins = {
  {
    "davidbachmann/vim-punk-colorscheme"
  },
  {
    "ggandor/lightspeed.nvim",
  },
  {
    "psliwka/vim-smoothie"
  },
  {
    'alvan/vim-closetag'
  },
  {
    "tpope/vim-surround",
  },
  {
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  {
    "bkad/CamelCaseMotion"
  },
  {
    "folke/trouble.nvim",
      cmd = "TroubleToggle",
  },
}
