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
    $installList = "" | Select-Object -Property appsList, dismList
    $appValues = $null
    $dismValues = $null

    ForEach( $_ in $ArgList )
    {
        $apps = $configFile.apps.$_
        $dism = $configFile.dism.$_
        $flag = $_.StartsWith('-')

        if ( [string]::IsNullOrWhiteSpace( $apps ) -eq $false -and ( -not ( $flag ) ) )
        {
            $appValues += $apps | Select-Object
        }
        elseif ( [string]::IsNullOrWhiteSpace( $dism ) -eq $false -and ( -not ( $flag ) ) )
        {
            $dismValues += $dism | Select-Object
        }
        else
        {
            $err = [string]::Format( "The category ""{0}"" does not exist in {1}",$_, $configPath.Split("\")[-1] )
            throw $err
        }

    }

    $installList.appsList = $appValues
    $installList.dismList = $dismValues

    $installList
}

Write-Host "Preparing a list of applications for batch install"

$installList = Add-Apps

if ( $args -contains '--all-apps' )
{
    $installList.appsList = $configFile.apps | Select-Object -ExpandProperty *
}

$chocoAppList = $installList.appsList
$dismAppList = $installList.dismList

Invoke-Expression "$PSScriptRoot\BatchInstall.ps1 ""$chocoAppList"" ""$dismAppList"" ""$logLevel"""
