# Remove-ApplicationByDisplayName
Remove an installed application using the Programs and Features display name

## SYNOPSIS
 Uninstall an application based on the name in Programs and Features

## DESCRIPTION
 Will accept a DisplayName value that will be searched for in Programs and Features.

### PARAMETER DisplayName
 The DisplayName as it found in Programs and Features. Wildcards are accepted but should be used with care.

### PARAMETER LogPath
 [Optional] Full path to the client logs folder

### PARAMETER LogName
 [Optional] allows the log file name to be explictly set.

### PARAMETER LogNamePrepend
 [Optional] allows a prepend to the auto-generated log file name.

### NOTES
 Author: Mark Allen
 Created: 16/08/2018

### LINK
 https://medium.com/@markhenryallen/remove-a-windows-application-using-the-displayname-c641aadc684c
 http://www.markallenit.com/blog/

### EXAMPLE
```powershell
.\Remove-Application.ps1 -DisplayName 'Google Chrome'
```
 Will find any entry in Programs and Features named 'Google Chrome' and will uninstall it.
 The script log file will be at the default location with the default name:  
    'C:\Windows\Temp\Remove-Application Google Chrome.log'

### EXAMPLE
```powershell
 .\Remove-Application.ps1 -DisplayName 'Google Chrome' -LogPath 'C:\Logs' -LogName 'Uninstall Google Chrome'
 ```
 Will find any entry in Programs and Features named 'Google Chrome' and will uninstall it.
 The script log file will be at the default location with the default name:  
    'C:\Logs\Uninstall Google Chrome.log'

### EXAMPLE
```powershell
.\Remove-Application.ps1 -DisplayName '7-Zip * (x64 edition)'
```
 Will find any entry in Programs and Features like '7-Zip * (x64 edition)' and will uninstall it.
 '*' is a wildcard that will be substituted by the version number in this example.
 The script log file will be at the default location with the default name and the wild card swapped with hyphen:
    'C:\Windows\Temp\Remove-Application 7-Zip - (x64 edition).log'
