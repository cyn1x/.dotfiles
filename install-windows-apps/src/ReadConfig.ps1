<#
    .Description
    Reads in a JSON configuration file
#>

$configFile = $PSScriptRoot + '\..\etc\config.json'

if ( [System.IO.File]::Exists( $configFile ) -eq $false )
{
    throw "Config file does not exist"
}

try
{
    $fileContents = $PowerShellObject=Get-Content -Path $configFile | ConvertFrom-Json
}
catch
{
    Write-Host "Error parsing config"
}
