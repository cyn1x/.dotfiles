<#
    .Description
    Automatically installs applications from categories given in the command-line.
    .Inputs
    Categories in config.json
    .Example
    .\Start.ps1 core windowsFeatures -q
#>

. "$PSScriptRoot\ReadConfig.ps1"

$configPath = $PSScriptRoot + '\..\etc\config.json'
$configFile
$ArgList
$logLevel

if ( $args -contains '-q' )
{
    Write-Host 'Package manager will not display progress indicators'

    $logLevel = '-q'
}

$configFile = Read-ConfigFile -FilePath $configPath

# Strip all flags from the argument list and copy to the application list array
$ArgList = $args | Where-Object { ( -not ( $_.StartsWith('-' ) ) ) }

Function Add-Apps
{
    $installList = "" | Select-Object -Property wingetAppList, chocoAppList, chocoDismList
    $wingetAppValues = $null
    $chocoAppValues = $null
    $chocoDismValues = $null

    ForEach( $_ in $ArgList )
    {
        $wingetApps = $configFile.winget.apps.$_
        $chocoApps = $configFile.choco.apps.$_
        $chocoDism = $configFile.choco.dism.$_
        $flag = $_.StartsWith('-')
        
        # The category could be in either winget, choco, or both
        if ( [string]::IsNullOrWhiteSpace( $chocoApps ) -eq $false -and ( -not ( $flag ) ) )
        {
            $chocoAppValues += $chocoApps | Select-Object
        }
        if ( [string]::IsNullOrWhiteSpace( $wingetApps ) -eq $false -and ( -not ( $flag ) ) )
        {
            $wingetAppValues += $wingetApps | Select-Object
        }
        elseif ( [string]::IsNullOrWhiteSpace( $chocoDism ) -eq $false -and ( -not ( $flag ) ) )
        {
            $chocoDismValues += $chocoDism | Select-Object
        }
        else
        {
            $msg = [string]::Format( "The category ""{0}"" does not exist in {1}",$_, $configPath.Split("\")[-1] )
            Write-Host $msg
        }

    }

    $installList.wingetAppList = $wingetAppValues
    $installList.chocoAppList = $chocoAppValues
    $installList.chocoDismList = $chocoDismValues

    $installList
}

Write-Host "Preparing a list of applications for batch install"

$installList = Add-Apps

if ( $args -contains '--all-apps' )
{
    $installList.wingetAppList = $configFile.winget.apps | Select-Object -ExpandProperty *
    $installList.chocoAppList = $configFile.choco.apps | Select-Object -ExpandProperty *
}

$wingetAppList = $installList.wingetAppList
$chocoAppList = $installList.chocoAppList
$chocoDismList = $installList.chocoDismList

Invoke-Expression "$PSScriptRoot\BatchInstall.ps1 ""$wingetAppList"" ""$chocoAppList"" ""$chocoDismList"" ""$logLevel"""
