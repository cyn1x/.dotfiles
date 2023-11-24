-- [[ Setting options ]]
-- See `:help vim.o`

require('util')

-- Load user config
vim.o.exrc = true
vim.o.secure = true

-- Make cursor blink when inactive
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" ..
    ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" ..
    ",sm:block-blinkwait175-blinkoff150-blinkon175"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Tab settings
vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Indent when starting a new line
vim.o.smartindent = true

-- Prevent text wrap
vim.o.wrap = false

-- Set highlight on search but do not highlight previous searches
vim.o.hlsearch = false
vim.o.incsearch = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Disable backups
vim.o.backup = false
vim.o.swapfile = false
-- Save undo history
vim.o.undofile = true
vim.o.undodir = GetEnv() .. "/.vim/undodir"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Included characters in file names.
--  See `:help 'isfname'`
vim.opt.isfname:append("@-@")

-- Minimum number of lines to show above or below the cursor
vim.o.scrolloff = 8

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
