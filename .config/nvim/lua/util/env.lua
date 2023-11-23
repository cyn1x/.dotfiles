-- [[ Environment Utilities ]]

function GetEnv()
    if vim.fn.has("win32") == 1 then
        return os.getenv("USERPROFILE")
    elseif vim.fn.has("unix") == 1 then
        return os.getenv("HOME")
    else
        return nil
    end
end
