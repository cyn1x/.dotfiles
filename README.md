# .dotfiles

[dotfile](https://en.wiktionary.org/wiki/dotfile)

## Configurations

Configurations for operating systems and any programs I use.

### Windows

Always a work in progress due to the everchanging landscape of the operating system.

Setup:
1. Run `%USERPROFILE%\.dotfiles\scripts\setup.bat` with administrative privileges.
2. Run `%USERPROFILE%\.dotfiles\scripts\setup\win\src\Start.ps1` with a valid `config.json` file.

### Neovim

My Neovim config is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by TJ DeVries and can be found [here](https://github.com/cyn1x/.dotfiles/tree/main/.config/nvim). The implementation has been modified with my own additions and refactored idiomatically using these [.dotfiles](https://github.com/folke/dot/tree/master/nvim) by Folke Lemaitre.

#### Dependencies

My setup varies for my primary development device(s) and secondary device(s).

##### Windows

MSVC installation and configuration instructions to compile C and C++ programs.

🪶 Lightweight
- Microsoft Visual Studio 2026 Build Tools

🥊 Heavyweight
- Microsoft Visual Studio 2026 Community

ℹ️ Common
- Workloads
  - Desktop Development for C++
- Individual components
  - C++ Clang Compiler for Windows

Usage reference for when development environments are omitted from the README of certain projects.

Microsoft Visual Studio Build Tools 2026 [seems](https://github.com/dotnet/msbuild/discussions/7114) to be installed in Program Files (x86).
```cmd
"C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
```

Use the 64-bit path for Microsoft Visual Studio Community.
```cmd
"C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
```

The Clang compiler toolchain is used for the [Neovim LSP configuration](..\config\nvim\after\plugin\lsp.lua).

##### Linux

Clang is also used in Linux as the Neovim LSP config, and mainly used for compiling larger projects.

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

To update submodules, use the command below.

```
git submodule update --remote
```

