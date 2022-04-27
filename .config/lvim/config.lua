-- Null-ls configuration
local null_ls = require("null-ls")

-- Register null-ls sources
local sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({ sources = sources })

vim.o.cmdheight = 1

vim.opt.guifont = "Hack Nerd Font Mono:h15"
vim.opt.termguicolors = true
vim.opt.mouse = ""

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "punk"

-- Enable Blamer for git blames
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_insert_modes = 0
vim.g.blamer_date_format = '%d/%m/%y'

-- Use , instead of leader for bkad/CamelCaseMotion
vim.g.camelcasemotion_key = ','

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
  ["<esc>"] = "<cmd>nohlsearch<cr>", -- Turn off highlight after search
  ["<tab>"] = "<C-w>", -- Tab is the same as pressing ctrl-w
  ["<tab><tab>"] = "<C-w>w", -- ctrl-w-w
  ["ScrollWheelUp"] = "<Nop>", -- disable mouse scroll
  ["ScrollWheelDown"] = "<Nop>", -- disable mouse scroll
  ["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>", -- Switch buffers
  ["<S-l>"] = "<cmd>BufferLineCycleNext<cr>", -- Switch buffers
}

-- keymappings that WhichKey should manage and display
lvim.builtin.which_key.mappings["E"] = {
  name = "eslint_d",
  f = {"mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F", "Fix buffer"},
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- I actually need to type kj and jk on occation
lvim.keys.insert_mode['jj'] = false
lvim.keys.insert_mode['jk'] = false
lvim.keys.insert_mode['kj'] = false

-- I use J for joining lines
lvim.keys.visual_block_mode['J'] = false

-- I like K for lsp.hover
lvim.keys.visual_block_mode['K'] = false

-- Show filename and path in lualine
lvim.builtin.lualine.sections.lualine_b = {
  {
    'filename',
    file_status = true, -- displays file status (readonly status, modified status)
    path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
  }
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.nvimtree.setup = {
  view = {
    width = 36,
    side = "left",
    auto_resize = true,
    mappings = {
      list = {
        { key = "<Tab>", action = "", }
      }
    }
  },
  update_focused_file = {
    enable = true
  }
}


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
    "ur4ltz/surround.nvim",
      config = function()
        require"surround".setup {mappings_style = "surround"}
      end
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
    "APZelos/blamer.nvim"
  }
}
