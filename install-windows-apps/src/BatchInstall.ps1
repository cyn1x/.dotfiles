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
    [string]$chocoAppList,
    [string]$dismAppList,
    [string]$logLevel
)

if ( $logLevel -eq '-q' )
{
    $logLevel = '--no-progress'
}

if ( [string]::IsNullOrWhiteSpace( $chocoAppList ) -eq $false -or [string]::IsNullOrWhiteSpace( $dismAppList ) -eq $false )
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
}

Function Install-Apps
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
            Write-Host "DISM features specified" -ForegroundColor Green

            $additionalArgs = '--source windowsfeatures'
        }
        else
        {
            Write-Host "Chocolatey apps specified" -ForegroundColor Green
        }

        foreach ( $app in $appsToInstall )
        {
            Write-Host "Installing $app"
            & choco install $app /y $additionalArgs $logLevel | Write-Output
        }
    }
}

Install-Apps -AppList $chocoAppList
Install-Apps -AppList $dismAppList
