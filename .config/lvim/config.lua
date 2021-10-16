vim.opt.relativenumber = true -- set relative numbered lines

-- Use , instead of leader for bkad/CamelCaseMotion
vim.g.camelcasemotion_key = ','

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
lvim.keys.normal_mode["<esc>"] = "<cmd>nohlsearch<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- lvim.builtin.nvimtree.update_focused_file

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
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Configure builtin plugins
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true

-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false

-- Additional Plugins
lvim.plugins = {
  {"bluz71/vim-nightfly-guicolors"},
  {"bkad/CamelCaseMotion"},
  {
    "folke/trouble.nvim",
      cmd = "TroubleToggle",
  },
}
