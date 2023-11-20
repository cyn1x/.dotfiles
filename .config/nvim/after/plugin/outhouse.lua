require('outhouse').setup{
    auto_start = true,
    vertical = true
}

local handler = require('outhouse.handler')

vim.keymap.set("n", "<leader><leader>x", function()
    if vim.fn.has("win32") == 1 then
        handler.subprocess(vim.g.win32_build_filename)
    elseif vim.fn.has("unix") == 1 then
        handler.subprocess(vim.g.unix_build_filename)
    else
        error("Platform not supported", 2)
    end
end)
