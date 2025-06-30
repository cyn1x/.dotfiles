@echo off

mklink /h %USERPROFILE%\.gitconfig %USERPROFILE%\.dotfiles\.gitconfig
mklink /d %USERPROFILE%\.dotfiles\scripts\setup\win\etc %USERPROFILE%\.config
mklink /d %USERPROFILE%\.nvim\plugins\outhouse.nvim %USERPROFILE%\Dev\GitHub\cyn1x\outhouse.nvim
mklink /d %LOCALAPPDATA%\nvim %USERPROFILE%\.dotfiles\.config\nvim
mklink /d C:\Dev %USERPROFILE%\Dev
