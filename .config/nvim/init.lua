vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.clipboard:append('unnamedplus')
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")
require("config.lsp-zero")

vim.cmd.colorscheme "tokyonight-night"
