# .dotfiles

## Configurations

Configurations for programs.

### Neovim

My Neovim config is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by TJ DeVries and can be found [here](https://github.com/cyn1x/.dotfiles/tree/main/.config/nvim). The implementation has been modified with my own additions and refactored idiomatically using these [.dotfiles](https://github.com/folke/dot/tree/master/nvim) by Folke Lemaitre.

## Setup

After the standard clone without the `--recurse-submodules` flag, clone specific submodules using the command below.

```cmd
git submodule update --init <submodule>
```

## Usage

To add further submodules, use the command below where `<submodule>` is the SSH target of the repo.

```cmd
git submodule add <submodule> <dir>
```
