@echo off

mklink /h %USERPROFILE%\.gitconfig %USERPROFILE%\.dotfiles\.gitconfig
mklink /d %USERPROFILE%\.nvim\plugins\outhouse.nvim D:\Dev\GitHub\outhouse.nvim
mklink /d %LOCALAPPDATA%\nvim %USERPROFILE%\.dotfiles\.config\nvim
