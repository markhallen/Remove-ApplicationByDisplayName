# Remove-ApplicationByDisplayName
Remove an installed application using the Programs and Features display name

## SYNOPSIS
 Uninstall an application based on the exact name in Programs and Features

## DESCRIPTION
 Will accept a DisplayNamee value that will be searched for in Programs and Features.

## PARAMETER DisplayName
 The DisplayName as it found in Programs and Features

## PARAMETER LogPath
 [Optional] Full path to the client logs folder

## PARAMETER LogName
 [Optional] allows the log file name to be explictly set.

## PARAMETER LogNamePrepend
 [Optional] allows a prepend to the auto-generated log file name.

## NOTES
 Author: Mark Allen
 Created: 16/08/2018

## LINK
 https://medium.com/@markhenryallen/remove-a-windows-application-using-the-displayname-c641aadc684c
 http://www.markallenit.com/blog/

## EXAMPLE
```powershell
.\Remove-Application.ps1 -DisplayName 'Google Chrome'
```
 Will find any entry in Programs and Features named 'Google Chrome and will uninstall it.
 The script log file will be at the default location with the default name:  
    'C:\Windows\Temp\Remove-Application Google Chrome.log'

## EXAMPLE
```powershell
 .\Remove-Application.ps1 -DisplayName 'Google Chrome' -LogPath 'C:\Logs' -LogName 'Uninstall Google Chrome'
 ```
 Will find any entry in Programs and Features named 'Google Chrome and will uninstall it.
 The script log file will be at the default location with the default name:  
    'C:\Logs\Uninstall Google Chrome.log'
