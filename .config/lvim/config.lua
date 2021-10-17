vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.guifont = "Hack Nerd Font Mono:h15"
-- Use , instead of leader for bkad/CamelCaseMotion
vim.g.camelcasemotion_key = ','

-- Disable mouse clicks
vim.opt.mouse = ""

lvim.lsp.diagnostics.virtual_text = true

lvim.builtin.dashboard.custom_header = {
" :::::::::  :::::::::  :::::::::::    ::::::::::: ::::::::  ",
" :+:    :+: :+:    :+:     :+:            :+:    :+:    :+: ",
" +:+    +:+ +:+    +:+     +:+            +:+    +:+        ",
" +#+    +:+ +#++:++#+      +#+            +#+    +#++:++#++ ",
" +#+    +#+ +#+    +#+     +#+            +#+           +#+ ",
" #+#    #+# #+#    #+# #+# #+#   #+#      #+#    #+#    #+# ",
" #########  #########   #####    ###  ########### ########  ",
}

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "nightfly"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
  ["<esc>"] = "<cmd>nohlsearch<cr>", -- Turn off highlight after search
  ["<Tab>"] = "<C-w>", -- Tab is the same as pressing ctrl-w
  ["ScrollWheelUp"] = "<Nop>", -- disable mouse scroll
  ["ScrollWheelDown"] = "<Nop>", -- disable mouse scroll
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

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
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true

lvim.lsp.diagnostics.virtual_text = true

-- Additional Plugins
lvim.plugins = {
  {
    "bluz71/vim-nightfly-guicolors"
  },
  {
    "psliwka/vim-smoothie"
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
    "tpope/vim-surround",
     keys = {"c", "d", "y"}
  },
  {
    "bkad/CamelCaseMotion"
  },
  {
    "folke/trouble.nvim",
      cmd = "TroubleToggle",
  },
  "ggandor/lightspeed.nvim",
  setup = function()
    require'lightspeed'.setup {
      jump_to_first_match = true,
      jump_on_partial_input_safety_timeout = 400,
      -- This can get _really_ slow if the window has a lot of content,
      -- turn it on only if your machine can always cope with it.
      highlight_unique_chars = false,
      grey_out_search_area = true,
      match_only_the_start_of_same_char_seqs = true,
      limit_ft_matches = 5,
      x_mode_prefix_key = '<c-x>',
      substitute_chars = { ['\r'] = '¬' },
      instant_repeat_fwd_key = nil,
      instant_repeat_bwd_key = nil,
      -- If no values are given, these will be set at runtime,
      -- based on `jump_to_first_match`.
      labels = nil,
      cycle_group_fwd_key = nil,
      cycle_group_bwd_key = nil,
    }
  end
}
