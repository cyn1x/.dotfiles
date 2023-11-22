function SetColorScheme(color)
    color = color or 'kanagawa-dragon'
    vim.cmd.colorscheme(color)
end

SetColorScheme()
