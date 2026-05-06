--leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--tmux settings for file name
vim.opt.title = true
vim.opt.titlestring = '%t'

vim.o.clipboard = 'unnamedplus'


-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true 

vim.o.number = true --Enables line numbers
vim.o.relativenumber = true --Enables relative line numbers
vim.o.mouse = 'a' -- Enable mouse mode (default: '')
vim.o.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.o.splitright = true -- Force all vertical splits to go to the right of current window (default: false)
vim.o.wrap = false -- Display lines as one long line (default: true)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.undofile = true -- Save undo history (default: false)
vim.o.showmode = true -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.o.breakindent = true -- Enable break indent (default: false)
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true -- Smart case (default: false)
vim.o.updatetime = 250 -- Decrease update time (default: 4000)
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

--KICKSTARTER OPTIONS
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
