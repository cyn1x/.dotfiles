vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" ..
    ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" ..
    ",sm:block-blinkwait175-blinkoff150-blinkon175"

vim.o.mouse = 'a'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (function()
    if vim.fn.has("win32") == 1 then
        return os.getenv("USERPROFILE")
    elseif vim.fn.has("unix") == 1 then
        return os.getenv("HOME")
    else
        return nil
    end
end)() .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.o.exrc = true
vim.o.secure = true

