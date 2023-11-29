-- This plugin doesn't have to be enabled for every project
local function load()
    require('outhouse').setup {
        disabled = false,
        auto_start = false,
        vertical = true
    }
end

-- The local plugin might not exist if not using my personal device(s)
--  for local plugin development
local status, err = pcall(load)

_ = err
if status == false then
    return
end

local handler = require('outhouse.handler')

vim.keymap.set("n", "<leader>cx", function()
    if vim.fn.has("win32") == 1 then
        handler.subprocess(vim.g.win32_build_filename)
    elseif vim.fn.has("unix") == 1 then
        handler.subprocess(vim.g.unix_build_filename)
    else
        error("Platform not supported", 2)
    end
end)
