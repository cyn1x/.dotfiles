# install-windows-apps

Installs applications for the Windows Operating System using the Winget and/or Chocolatey package manager.

The purpose of this is to remove the tedious repetitive work from provisioning or resetting devices at home using Microsoft 
Deployment Toolkit (MDT) or requiring installs out of hours to make use of off-peak internet quota.

## Usage

Edit the config file by adding Winget and/or Chocolatey package names into the JSON arrays.

```json
{
  "winget":[
    {
      "apps":[
        {
          "core": [
            "Mozilla.Firefox",
            "Google.Chrome",
            "VideoLAN.VLC",
            "7zip.7zip"
          ]
        },
        {
          "coreDev": [
            "Microsoft.VisualStudioCode",
            "Git.Git"
          ]
        },
        {
          "webDev": [
            "GoLang.Go"
          ]
        },
        {
          "avTools": [
            "Audacity.Audacity",
            "OBSProject.OBSStudio",
            "Gyan.FFmpeg"
          ]
        }
      ]
    }
  ],
  "choco":[
    {
      "dism": [
        {
          "windowsFeatures": [
            "telnet"
          ]
        }
      ],
      "apps":[
        {
          "coreDev": [
            "adb"
          ]
        }
      ]
    }
  ]
}
```

Run the main script file by providing arguments corresponding to the categories under `apps` in the JSON file. 

```powershell
cd .\src
.\Start.ps1 core coreDev webDev avTools windowsFeatures
```

The `--all-apps` flag can be passed in to install all Chocolatey applications, but DISM still must be manually specified. Additionally, the `-q` flag is useful for supressing Chocolatey progress indicators for when logging to a file.

```powershell
.\Start.ps1 --all-apps windowsFeatures -q > %TEMP%\install-windows-apps.log
```

## Resources
Package names for each package manager can be found at the following locations

### Winget
https://winget.run/
https://winstall.app/

### Chocolatey
https://community.chocolatey.org/packages
