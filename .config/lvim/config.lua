-- Null-ls configuration
-- Register null-ls sources

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.diagnostics.eslint_d,
  }
})



vim.o.cmdheight = 1
vim.opt.timeoutlen = 1000
vim.o.updatetime = 250

-- Disable virtual text disagnostics
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.underline = true
-- and enable floating diagnostics
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

vim.opt.guifont = "Hack Nerd Font Mono:h15"
vim.g.camelcasemotion_key = ','

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.insert_mode["˚"] = "<Esc>:m .-2<CR>==gi"
lvim.keys.insert_mode["∆"] = "<Esc>:m .+1<CR>==gi"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<esc>"] = "<cmd>nohlsearch<cr>" -- Turn off highlight after search

lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

-- Switch line positions up/down
lvim.keys.normal_mode["˚"] = "<Esc>:m .-2<CR>=="
lvim.keys.normal_mode["∆"] = "<Esc>:m .+1<CR>=="
lvim.keys.normal_mode["<A-k>"] = "<Esc>:m .-2<CR>=="
lvim.keys.normal_mode["<A-j>"] = "<Esc>:m .+1<CR>=="

-- Switch to window left/right
lvim.keys.normal_mode["˙"] = "<C-w>h"
lvim.keys.normal_mode["¬"] = "<C-w>l"
lvim.keys.normal_mode["<A-h>"] = "<C-w>h"
lvim.keys.normal_mode["<A-k>"] = "<C-w>k"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["E"] = {
  name = "eslint_d",
  f = { "mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F", "Fix buffer" },
}

lvim.builtin.which_key.mappings["C"] = { "<cmd>NoNeckPain<CR>", "Center/NoNeckPain.nvim" }


-- I actually need to type kj and jk on occation
lvim.keys.insert_mode['jj'] = false
lvim.keys.insert_mode['jk'] = false
lvim.keys.insert_mode['kj'] = false

-- I use J for joining lines
lvim.keys.visual_block_mode['J'] = false

-- I like K for lsp.hover
lvim.keys.visual_block_mode['K'] = false

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.adaptive_size = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
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

-- Additional Plugins
lvim.plugins = {
  {
    "psliwka/vim-smoothie"
  },
  {
    "ggandor/leap.nvim",
    event = 'BufRead',
    config = function()
      require('leap').add_default_mappings(true)
    end
  },
  {
    "bkad/CamelCaseMotion"
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "shortcuts/no-neck-pain.nvim",
    config = function()
      require("no-neck-pain").setup({
        -- The width of the focused buffer when enabling NNP.
        -- If the available window size is less than `width`, the buffer will take the whole screen.
        width = 143,
        -- Prints useful logs about what event are triggered, and reasons actions are executed.
        debug = false,
        -- Disables NNP if the last valid buffer in the list has been closed.
        disableOnLastBuffer = false,
        -- When `true`, disabling NNP kills every split/vsplit buffers except the main NNP buffer.
        killAllBuffersOnDisable = false,
        -- Options related to the side buffers.
        buffers = {
          -- The background options of the side buffer(s).
          background = {
            colorCode = nil,
          },
          -- When `false`, the `left` padding buffer won't be created.
          left = true,
          -- When `false`, the `right` padding buffer won't be created.
          right = true,
          -- When `true`, the side buffers will be named `no-neck-pain-left` and `no-neck-pain-right` respectively.
          showName = false,
          -- The buffer options when creating the buffer.
          options = {
            -- Buffer-scoped options, below are the default values, but any `vim.bo` options are valid and will be forwarded to the buffer creation.
            bo = {
              filetype = "no-neck-pain",
              buftype = "nofile",
              bufhidden = "hide",
              modifiable = false,
              buflisted = false,
              swapfile = false,
            },
            -- Window-scoped options, below are the default values, but any `vim.wo` options are valid and will be forwarded to the buffer creation.
            wo = {
              cursorline = false,
              cursorcolumn = false,
              number = false,
              relativenumber = false,
              foldenable = false,
              list = false,
            },
          },
        },
      })
    end
  }
}
