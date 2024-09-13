<#
    .Description
    Determines whether there are Chocolatey applications to install and/or DISM applications to install
    .Inputs
    List of Chocolatey apps, a list of DISM apps, and a log level to determine verbosity
    .Example
    Invoke-Expression "$PSScriptRoot\BatchInstall.ps1 ""$chocoAppList"" ""$dismAppList"" ""$logLevel"""
    .Notes
    Thanks to the article below from Bob Walker which gave the initial foundations to build upon
    https://octopus.com/blog/automate-developer-machine-setup-with-chocolatey
#>

Param(
    [string]$wingetAppList,
    [string]$chocoAppList,
    [string]$dismAppList,
    [string]$logLevel
)

if ( $logLevel -eq '-q' )
{
    $logLevel = '--no-progress'
}

Function Install-Winget-Apps
{
    param (
        $AppList
    )

    if ( [string]::IsNullOrWhiteSpace( $appList ) -eq $false )
    {    
        $appsToInstall = $appList -split " " | foreach { "$( $_.Trim() )" }

        if ( $AppList -eq $wingetAppList )
        {
            Write-Host 'Winget apps specified' -ForegroundColor Green
        }

        foreach ( $app in $appsToInstall )
        {
            Write-Host "Installing $app"
            & winget install $app -h | Write-Output
        }
    }
}

Function Install-Chocolatey-Apps
{
    param (
        $AppList
    )

    $additionalArgs

    if ( [string]::IsNullOrWhiteSpace( $appList ) -eq $false )
    {    
        $appsToInstall = $appList -split " " | foreach { "$( $_.Trim() )" }

        if ( $AppList -eq $dismAppList )
        {
            Write-Host 'DISM features specified' -ForegroundColor Green

            $additionalArgs = '--source windowsfeatures'
        }
        else
        {
            Write-Host 'Chocolatey apps specified' -ForegroundColor Green
        }

        foreach ( $app in $appsToInstall )
        {
            Write-Host "Installing $app"
            & choco install $app /y $additionalArgs $logLevel | Write-Output
        }
    }
}

Function Show-Apps
{
    param (
        $Name,
        $AppList
    )

    if ( [string]::IsNullOrWhiteSpace( $appList ) -eq $false )
    {
        $msg = [string]::Format( "=============== {0} ===============", $name )

        Write-Host $msg
        Write-Host $appList -Separator ', '

        # Blank newline after name and list applications
        Write-Host
    }
}

Function Show-Data
{
    # Blank newline before session information
    Write-Host

    Write-Host "Preparing session data `n"

    Show-Apps -Name "Winget" -AppList $wingetAppList
    Show-Apps -Name "Chocolatey" -AppList $chocoAppList
    Show-Apps -Name "DISM" -AppList $dismAppList
}

if ([string]::IsNullOrWhiteSpace( $wingetAppList ) -eq $false)
{
    Install-Winget-Apps -AppList $wingetAppList
}

if ( 
    [string]::IsNullOrWhiteSpace( $chocoAppList ) -eq $false -or 
    [string]::IsNullOrWhiteSpace( $dismAppList ) -eq $false
    )
{
    try
    {
        choco config get cacheLocation
    }
    catch
    {
        Write-Output "Chocolatey not detected, trying to install now"
        iex ( ( New-Object System.Net.WebClient ).DownloadString( 'https://chocolatey.org/install.ps1' ) )
    }

    Show-Data

    Install-Chocolatey-Apps -AppList $chocoAppList
    Install-Chocolatey-Apps -AppList $dismAppList
}
else
{
    throw 'No arguments or applications specified through command-line parameters or config.json'
}
