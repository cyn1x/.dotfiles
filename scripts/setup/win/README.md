# install-windows-apps

Installs applications for the Windows Operating System using the Winget and/or Chocolatey package manager.

The purpose of this is to remove the tedious repetitive work from provisioning or resetting devices at home using Microsoft 
Deployment Toolkit (MDT) or requiring installs out of hours to make use of off-peak internet quota.

## Installation

Clone only the bin directory from the project folder in the [repository](https://github.com/cyn1x/.dotfiles.git) to obtain the compressed file if the entire repository is not required. The entire repository is not required thanks to [this](https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934) StackOverflow post.

```powershell
cd ~\
git clone --depth 1 --filter=blob:none --sparse https://github.com/cyn1x/.dotfiles.git
cd .dotfiles
git sparse-checkout set .dotfiles/setup/win
cd .\setup\win
Expand-Archive -Path .\bin\install-win-apps.zip -DestinationPath .
```

Edit the config file in the `etc` directory as per the examples in this README file.

## Usage

Edit the config file by adding Winget and/or Chocolatey package names into the JSON arrays. The example below uses
Chocolatey package names.

```json
  "apps": [{
    "core": [
      "vlc",
      "audacity"
    ]
  },
  {
    "coreDev": [
      "visualstudio2019community",
      "vscode",
      "atom",
      "git"
    ]
  },
  {
    "webDev": [
      "golang",
      "awscli",
      "nvm"
    ]
  },
```

Also, Windows features can be installed by adding them under the `windowsFeatures` JSON array.

```JSON
  "dism": [{
    "windowsFeatures": [
      "telnet"
    ]
  }
```

Run the main script file by providing arguments corresponding to the categories under `apps` in the JSON file. Additionally, 

```powershell
cd .\src
.\Start.ps1 core coreDev webDev windowsFeatures
```

The `--all-apps` flag can be passed in to install all Chocolatey applications, but DISM still must be manually specified. Additionally, the `-q` flag is useful for supressing Chocolatey progress indicators for when logging to a file.

```powershell
.\Start.ps1 --all-apps windowsFeatures -q > %TEMP%\install-windows-apps.log
```

## Development

Compressing 

```powershell
cd ~.\dotfiles\scripts\setup\win\
Remove-Item .\bin\install-win-apps.zip
Compress-Archive -Path .\* -DestinationPath .\bin\install-win-apps.zip
```

## Resources
Package names for each package manager can be found at the following locations

### Winget
https://winget.run/
https://winstall.app/

### Chocolatey
https://community.chocolatey.org/packages
