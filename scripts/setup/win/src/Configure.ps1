<#
    .Description
    Sets the desired state of the operating system.
    .Inputs
    "Home" or "Work" depending on the device being configured.
    .Example
    .\Configure.ps1 "Home"
#>

param(
    [ValidateSet("Home", "Work")]
    [string]$Profile = "Home"
)

# Define config

$config = @{
    Home = @{
        Features       = @("Microsoft-Hyper-V-All", "TelnetClient")
        RemoveAppx     = @( # Appx bloatware
            "*BingNews*", "*BingSearch*", "*BingWeather*", "*Copilot*", "*Clipchamp*", 
            "*Disney*", "*LinkedIn*",
            "*Microsoft.Todos*", "*Microsoft.People*", "*MicrosoftEdge*", "*MSTeams*",
            "**WindowsCommunicationsApps*", "*WindowsMaps*", "*WebExperience*"
        )
        RemoveWinGet   = @( # WinGet bloatware
            "Microsoft.365Copilot",
            "9WZDNCRFJ3PT", # Windows Media Player
            "9NFTCH6J7FHV", # Power Automate
        ) 

        RemoveStartup  = @("OneDrive", "Steam", "Discord", "TIDAL", "Docker Desktop",
            "com.squirrel.slack.slack")
        Services       = @{ "OVRService" = "Manual" }
        DisableSearch  = $true
        
        # OLED monitor specific settings
        RemoveDesktopShortcuts = $true
        HideDesktopIcons = $true 
        AutoHideTaskbar  = $true 
        DarkTheme        = $true
        SolidBackground  = $true
        
        StartMenuView    = 1
        Language         = "en-AU"
        DisplayLanguage  = "en-AU"
    }
    Work = @{
        Features       = @("TelnetClient") # Hyper-V not required on VMs
        RemoveAppx     = @( # Appx bloatware
            "*BingNews*", "*BingSearch*", "*BingWeather*", "*Copilot*", "*Clipchamp*", 
            "*Disney*", "*LinkedIn*",
            "*Microsoft.Todos*", "*Microsoft.People*", "*MicrosoftEdge*", "*MSTeams*",
            "**WindowsCommunicationsApps*", "*WindowsMaps*", "*WebExperience*"
        ) 
        RemoveWinGet   = @ ( # WinGet bloatware
            "Microsoft.365Copilot",
            "9WZDNCRFJ3PT", # Windows Media Player
            "9NFTCH6J7FHV", # Power Automate
            "9MV0B5HZVK9Z", # XBOX
        ) 

        RemoveStartup  = @()
        Services       = @{}
        DisableSearch  = $true

        # OLED monitor specific settings
        RemoveDesktopShortcuts = $true
        HideDesktopIcons = $true 
        AutoHideTaskbar  = $true 
        DarkTheme        = $true
        SolidBackground  = $true

        StartMenuView    = 2
        Language         = "en-AU"
        DisplayLanguage  = ""
    }
}

$desired = $config[$Profile]
Write-Host "Applying '$Profile' profile..." -ForegroundColor Cyan

# Apply config

# Enable Optional Windows Features
foreach ($feature in $desired.Features) {
    Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
}

# Remove default Appx packages
foreach ($pkg in $desired.RemoveAppx) {
    Get-AppxPackage $pkg | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# Remove default WinGet apps
foreach ($app in $desired.RemoveWinGet) {
    winget uninstall $app
}

# Remove applications from Windows startup procedure
foreach ($item in $desired.RemoveStartup) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name $item -ErrorAction SilentlyContinue
}

# Disable automatic startup for Services
foreach ($svc in $desired.Services.GetEnumerator()) {
    Set-Service -Name $svc.Key -StartupType $svc.Value -ErrorAction SilentlyContinue
}

# Remove Bing Search, Cortana Search, and Taskbar Search
if ($desired.DisableSearch) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name CortanaEnabled -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name BingSearchEnabled -Value 0 -Type DWord -Force
}

# Delete desktop shotcuts
if ($desired.RemoveDesktopShortcuts) {
    $paths = @([Environment]::GetFolderPath("Desktop"), "C:\Users\Public\Desktop")
    foreach ($path in $paths) {
        Get-ChildItem $path -Filter *.lnk -ErrorAction SilentlyContinue | Remove-Item
    }
}

# Hide desktop icons
if ($desired.HideDesktopIcons) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideIcons -Value 1 -Type DWord -Force
}

# Automatically hide the Taskbar
if ($desired.AutoHideTaskbar) {
    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"
    $settings = (Get-ItemProperty -Path $path).Settings
    $settings[8] = $settings[8] -bor 0x01
    Set-ItemProperty -Path $path -Name Settings -Value $settings -Type Binary -Force
}

# Set the Windows Theme to "light" or "dark" mode
if ($desired.DarkTheme) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0 -Type DWord -Force
}

# Set the desktop background to a solid color
if ($desired.SolidBackground) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value "" -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name Background -Value "0 0 0" -Force
}

# Set the Windows display language
if ($desired.DisplayLanguage) {
    Set-SystemPreferredUILanguage -Language $lang
}

# Set the view mode for apps under "All" in the Windows Start Menu unde
if ($desired.StartMenuView) {
    $value = $desired.StartMenuView
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name "AllAppsViewMode" -Value $value
}

# Set default language
if ($desired.Language) {
    $lang = $desired.Language
    if (-not (Get-InstalledLanguage -Language $lang -ErrorAction SilentlyContinue)) {
        Install-Language -Language $lang -CopyToSettings
    }

    $langList = Get-WinUserLanguageList
    $targetLang = $langList | Where-Object LanguageTag -eq $lang
    
    # Prepends the preferred language to the top of the list under "Language" 
    # Settings → Time & Language → Language & Region
    $langList.Remove($targetLang)
    $langList.Insert(0, $targetLang)
    
    Set-WinUserLanguageList $langList -Force
}

Write-Host "Done. A sign-out or restart is recommended for language/UI changes to fully apply." -ForegroundColor Yellow
