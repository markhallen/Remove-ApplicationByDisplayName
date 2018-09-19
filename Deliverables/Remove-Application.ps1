<#
.SYNOPSIS
 Uninstall an application based on the exact name in Programs and Features

 .DESCRIPTION
 Will accept a DisplayNamee value that will be searched for in Programs and Features.

.PARAMETER DisplayName
 The DisplayName as it found in Programs and Features

.PARAMETER LogPath
 [Optional] Full path to the client logs folder

.PARAMETER LogName
 [Optional] allows the log file name to be explictly set.

.PARAMETER LogNamePrepend
 [Optional] allows a prepend to the auto-generated log file name.

.NOTES
 Author: Mark Allen
 Created: 16/08/2018

.LINK
 http://www.markallenit.com/blog/

.EXAMPLE
 .\Remove-Application.ps1 -DisplayName 'Google Chrome'
 Will find any entry in Programs and Features named 'Google Chrome and will uninstall it.
 The script log file will be at the default location with the default name:
    'C:\Windows\Temp\Remove-Application Google Chrome.log'

.EXAMPLE
 .\Remove-Application.ps1 -DisplayName 'Google Chrome' -LogPath 'C:\Logs' -LogName 'Uninstall Google Chrome'
 Will find any entry in Programs and Features named 'Google Chrome and will uninstall it.
 The script log file will be at the default location with the default name:
    'C:\Logs\Uninstall Google Chrome.log'

.EXAMPLE
.\Remove-Application.ps1 -DisplayName '7-Zip * (x64 edition)'
 Will find any entry in Programs and Features like '7-Zip * (x64 edition)' and will uninstall it.
 '*' is a wildcard that will be substituted by the version number in this example.
 The script log file will be at the default location with the default name and the wild card swapped with hyphen:
    'C:\Windows\Temp\Remove-Application 7-Zip - (x64 edition).log'
#>

[CmdletBinding( SupportsShouldProcess = $False, ConfirmImpact = "None", DefaultParameterSetName = "DisplayName" ) ]
param(
    [Parameter(
        ParameterSetName='DisplayName',
        Mandatory = $true,
        Position = 0
    )]
    [Parameter(
        ParameterSetName='LogPath',
        Mandatory = $true,
        Position = 0
    )]
    [Parameter(
        ParameterSetName='LogName',
        Mandatory = $true,
        Position = 0
    )]
    [Parameter(
        ParameterSetName='LogNameSandwich',
        Mandatory = $true,
        Position = 0
    )]
    [string]$DisplayName,

    [Parameter(
        ParameterSetName='LogPath'
    )]
    [Parameter(
        ParameterSetName='LogName'
    )]
    [Parameter(
        ParameterSetName='LogNameSandwich'
    )]
    [ValidateScript({Test-Path $(Split-Path $_) -PathType 'Container'})]
    [string]$LogPath = 'C:\Windows\Temp',

    [Parameter(
        ParameterSetName='LogName'
    )]
    [string]$LogName,

    [Parameter(
        ParameterSetName='LogNameSandwich'
    )]
    [string]$LogNamePrepend,

    [Parameter(
        ParameterSetName='LogNameSandwich'
    )]
    [string]$LogNameAppend
)

begin
{
    # region Initialize log files
    #
    $LogFileName = 'Remove-Application ' + $DisplayName
    if('' -ne $LogNamePrepend) { $LogFileName = $LogNamePrepend + ' ' + $LogFileName }
    if('' -ne $LogNameAppend) { $LogFileName = $LogFileName + ' ' + $LogNameAppend }
    if('' -ne $LogName) { $LogFileName = $LogName }

    [System.IO.Path]::GetInvalidFileNameChars() | ForEach-Object {$text = $text.replace($_,'-')}

    if(!($LogFileName.ToLower().EndsWith('.log'))) { $LogFileName = $LogFileName + '.log' }

    $Seperator = ''
    if(!($LogPath.EndsWith('\'))) { $Seperator = '\' }

    $LogFile = $LogPath + $Seperator + $LogFileName

    # append to or create the log file
    if(Test-Path $LogFile)
    {
        "`r`n***** Script Execution *****"  | Add-Content $LogFile
        Get-Date -Format F | Add-Content $LogFile
    }
    else
    {
        if (!(Test-Path -path $LOGPATH)){New-Item $LOGPATH -Type Directory}
        Get-Date -Format F | Set-Content $LogFile
    }
    #endregion

    # region Include required files
    #
    $ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $Dependencies = $ScriptDirectory + '\Dependencies'
    $Classes = $Dependencies + '\Classes'
    $Functions = $Dependencies + '\Functions'
    try {
        . ("$Classes\CommandString.Class.ps1")
        . ("$Functions\Get-ArpPropertyByDisplayName.ps1")
        . ("$Functions\Remove-ApplicationByDisplayName.ps1")
    }
    catch {
        "DEBUG: ScriptDirectory = " + $ScriptDirectory | Add-Content $LogFile
        "Error: " + $PSItem.Exception.Message | Add-Content $LogFile
        if($PSItem.Exception.InnerExceptionMessage) {
            "Inner exception: " + $PSItem.Exception.InnerExceptionMessage | Add-Content $LogFile
        }
        Write-Error "Error while loading supporting PowerShell Scripts" -ErrorAction Stop | Add-Content $LogFile
    }
    #endregion
}

process
{
    try {
        Remove-ApplicationByDisplayName -DisplayName $DisplayName | Add-Content $LogFile
    }
    catch {
        "DisplayName: " + $DisplayName | Add-Content $LogFile
        "Error: " + $PSItem.Exception.Message | Add-Content $LogFile
        if($PSItem.Exception.InnerExceptionMessage) {
            "Inner exception: " + $PSItem.Exception.InnerExceptionMessage | Add-Content $LogFile
        }
        Exit 3
    }
}

end
{
    "Script execution completed successfully" | Add-Content $LogFile
    Exit 0
}
