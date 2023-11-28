-- [[ Theme Setup ]]

-- Optionally loads a theme file that is provided by the user
--  in ~/.vim/theme.lua
function SetColorScheme(color)
    local theme = nil
    local function get_theme()
        local t = dofile(GetEnv() .. "/.vim/theme.lua")
        theme = t.colorscheme
    end

    -- The theme does not have to be defined on each machine
    pcall(get_theme)

    color = theme or color or 'kanagawa-dragon'
    vim.cmd.colorscheme(color)
end

SetColorScheme()
