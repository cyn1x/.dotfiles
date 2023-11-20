function SetColorScheme()
    local time = os.date("%H:%M:%S")
    local morning = time > os.date("08:00:00") and time < os.date("15:59:59")
    local afternoon = time > os.date("16:00:00") and time < os.date("23:59:59")

    if morning then
        vim.cmd.colorscheme('tokyonight-storm')
    elseif afternoon then
        vim.cmd.colorscheme('tokyonight-moon')
    else
        -- night
        vim.cmd.colorscheme('tokyonight-night')
    end
end

SetColorScheme()
