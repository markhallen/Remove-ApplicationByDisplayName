Function Remove-ApplicationByDisplayName
{
    <#
    .SYNOPSIS
    Remove an application from Windows

    .DESCRIPTION
    Will accept a DisplayName value that will be searched for in Programs and Features and will
    uninstall the applicationg.

    .PARAMETER DisplayName
    The DisplayName as it found in Programs and Features

    .NOTES
    Author: Mark Allen
    Created: 16/08/2018

    .LINK
    http://www.markallenit.com/blog/

    .EXAMPLE
    Get-ApplicationByDisplayName -DisplayName 'Google Chrome'
    Will find any entry in Programs and Features named 'Google Chrome and will uninstall
    it..
    #>
    param (
        [parameter(
            Mandatory=$true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [string]
            $DisplayName
    )

    begin
    {
        [String]$UninstallString = Get-ArpPropertyByDisplayName -DisplayName $DisplayName -Property QuietUninstallString
        if($null -eq $UninstallString) {
            $UninstallString = Get-ArpPropertyByDisplayName -DisplayName $DisplayName
        }
        if($null -eq $UninstallString) {
            Write-Error -Message "Can't find an uninstall string." -ErrorAction Stop
        }
        Write-Output "Found uninstall string: $UninstallString"
    }

    process
    {
        $UninstallString = [CommandString]::new($UninstallString).ToUninstall()

        try {
            Write-Output "Executing: " + $UninstallString
            Start-Process cmd -ArgumentList "/c $UninstallString" -NoNewWindow -Wait
            Write-Output "Finished Executing: " + $UninstallString
        }
        catch {
            Write-Output "Failed to execute: " + $UninstallString
            throw
        }
    }
}
