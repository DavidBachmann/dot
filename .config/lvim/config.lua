vim.o.cmdheight = 1
vim.opt.timeoutlen = 1000
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  underline = true
})
vim.opt.guifont = "Hack Nerd Font Mono:h15"
vim.g.camelcasemotion_key = ','
-- general
lvim.format_on_save = true
lvim.colorscheme = "dracula"
lvim.leader = "space"

lvim.keys.normal_mode["<esc>"] = "<cmd>nohlsearch<cr>" -- Turn off highlight after search
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

-- Switch line positions up/down
lvim.keys.normal_mode["˚"] = "<Esc>:m .-2<CR>=="
lvim.keys.normal_mode["∆"] = "<Esc>:m .+1<CR>=="
lvim.keys.normal_mode["<A-k>"] = "<Esc>:m .-2<CR>=="
lvim.keys.normal_mode["<A-j>"] = "<Esc>:m .1<CR>=="

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" }
}

lvim.builtin.which_key.mappings["sT"] = { "<cmd>Telescope live_grep search_dirs=.<CR>", "Search Local Fext" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope find_files search_dirs=.<CR>", "Find Local Files" }
lvim.builtin.which_key.mappings["bs"] = { "<cmd>Scratch<CR>", "Open Scratch" }
lvim.builtin.which_key.mappings["bm"] = { "<cmd>MinimapToggle<CR><cmd>MinimapUpdateHighlight<CR>", "Toggle minimap" }

-- I actually need to type kj and jk on occation
lvim.keys.insert_mode['jj'] = false
lvim.keys.insert_mode['jk'] = false
lvim.keys.insert_mode['kj'] = false

-- I use J for joining lines
lvim.keys.visual_block_mode['J'] = false

-- I like K for lsp.hover
lvim.keys.visual_block_mode['K'] = false

-- smart-splits mappings
vim.keymap.set('n', '<C-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').resize_right)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

function navigate_windows()
  -- Default move to the next window
  vim.cmd('wincmd w')

  -- Get the buffer type of the current window
  local buf_type = vim.api.nvim_buf_get_option(0, 'buftype')

  -- If it's 'quickfix', move to the next window
  if buf_type == 'quickfix' then
    vim.cmd('wincmd w')
  end
end

vim.api.nvim_set_keymap('n', '<c-w>w', '<cmd>lua navigate_windows()<CR>', { noremap = true })

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
lvim.builtin.nvimtree.setup.view.width = 40

lvim.lsp.null_ls.config.lsp_definitions = {
  file_ignore_patterns = { "%.d.ts" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  {
    name = "prettierd",
    cmd = 'prettierd',
    filetypes = { "typescript", "typescriptreact", "javascript" },
  },
}

linters.setup {
  {
    name = 'eslint_d',
    cmd = 'eslint_d',
    filetypes = { "typescript", "typescriptreact", "javascript" },
  }
}


-- Additional Plugins
lvim.plugins = {
  {

    "Mofiqul/dracula.nvim",
  },
  {
    "psliwka/vim-smoothie"
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
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
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'mtth/scratch.vim',
    config = function()
      vim.cmd("set filetype=typescript")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { 'mrjones2014/smart-splits.nvim' }
}
