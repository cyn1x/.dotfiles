<#
    .Description
    Reads in a JSON configuration file
#>

Function Read-ConfigFile
{
    param (
        $FilePath
    )

    $fileContents

    if ( [System.IO.File]::Exists( $filePath ) -eq $false )
    {
        throw "Config file does not exist"
    }

    try
    {
        $fileContents = $PowerShellObject=Get-Content -Path $filePath | ConvertFrom-Json
    }
    catch
    {
        Write-Host "Error parsing config"
    }

    $fileContents
}
