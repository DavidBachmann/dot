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
lvim.colorscheme = "tokyonight"
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


local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    name = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript" },
  },
  { name = 'eslint' }
}


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
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    init = function()
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
      vim.g.minimap_git_colors = 1
    end,
  },
  {
    'mtth/scratch.vim',
    config = function()
      vim.cmd("set filetype=typescript")
    end,
  }
}

lvim.autocommands = {
  {
    "BufEnter",
    {
      pattern = { "*.json", "*.lua", "*.tsx", "*.ts", "*.js", "*.jsx" },
      callback = function()
        -- Workaround since I'm not getting Minimap to autostart
        vim.api.nvim_command("Minimap")
        vim.api.nvim_command("MinimapUpdateHighlight")
        vim.api.nvim_command("MinimapRefresh")
      end
    }
  },
  {
    "WinEnter",
    {
      pattern = "*",
      callback = function()
        ---@diagnostic disable: param-type-mismatch
        local mmwinnr = vim.fn.bufwinnr("-MINIMAP-")

        if mmwinnr == -1 then
          return
        end

        if vim.fn.winnr() == mmwinnr then
          -- Go to the other window.
          vim.api.nvim_command("wincmd t")
        end
      end
    }
  },
  { "QuitPre", {
    pattern = "*",
    callback = function()
      vim.api.nvim_command("MinimapClose")
    end
  } },
}
