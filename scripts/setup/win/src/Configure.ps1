# Remove searchbox from taskbar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Force

# Uninstall default programs
Start-Process powershell.exe 'Get-AppxPackage *Microsoft.People* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *WebExperience* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage' -NoNewWindow -PassThru -wait
Start-Process powershell.exe 'Get-AppxPackage *Disney* | Remove-AppxPackage' -NoNewWindow -PassThru -wait

# Remove Startup Items
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDrive" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Steam" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Discord" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "com.squirrel.slack.slack" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "TIDAL" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "electron.app.Notion" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "org.whispersystems.signal-desktop" -ErrorAction SilentlyContinue

# Remove Desktop Shortcut Icons
$DesktopPath = [Environment]::GetFolderPath("Desktop")

Get-ChildItem $DesktopPath -Filter *.lnk | Foreach-Object {
    $file = $_
    $path = Join-Path -Path $DesktopPath -ChildPath $file
    
    Remove-Item $path
}

# Disable Cortana & Bing Search
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaEnabled" /T REG_DWORD /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "BingSearchEnabled" /T REG_DWORD /D 0 /F
