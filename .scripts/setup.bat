@echo off

mklink /d %USERPROFILE%\.nvim\plugins\outhouse.nvim D:\Dev\GitHub\outhouse.nvim
mklink /h .gitconfig %USERPROFILE%\.dotfiles\.gitconfig

