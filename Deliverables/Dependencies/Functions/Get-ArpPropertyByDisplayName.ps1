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
        Where-Object {$_.DisplayName -eq $DisplayName } |
            Select-Object -ExpandProperty $Property
}