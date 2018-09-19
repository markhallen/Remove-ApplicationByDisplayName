function Get-ArpPropertyByDisplayName {
    <#
    .SYNOPSIS
    Get an application property from Programs and Features

    .DESCRIPTION
    Will accept a DisplayName value that will be searched for in Programs and Features and will
    return the property.

    .PARAMETER DisplayName
    The DisplayName as it found in Programs and Features

    .NOTES
    Author: Mark Allen
    Created: 16/08/2018

    .LINK
    http://www.markallenit.com/blog/

    .EXAMPLE
    Get-ArpPropertyByDisplayName -DisplayName 'Google Chrome'
    Will find any entry in Programs and Features named 'Google Chrome and will return the
    UninstallString.

    .EXAMPLE
    Get-ArpPropertyByDisplayName -DisplayName 'Google Chrome' -Property QuietUninstallString
    Will find any entry in Programs and Features named 'Google Chrome and will return the
    QuietUninstallString.

    .EXAMPLE
    Get-ArpPropertyByDisplayName -DisplayName '7-Zip * (x64 edition)'
    Will find any entry in Programs and Features like '7-Zip * (x64 edition)' and will return the
    UninstallString.
    '*' is a wildcard that will be substituted by the version number in this example.
    #>

    param (
        [parameter(
            Mandatory=$true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [string]
            $DisplayName,

        [parameter(
            Mandatory=$false
        )]
        [ValidateNotNullOrEmpty()]
        [string]
            $Property = 'UninstallString'
    )
    Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -like $DisplayName } |
            Select-Object -ExpandProperty $Property
}