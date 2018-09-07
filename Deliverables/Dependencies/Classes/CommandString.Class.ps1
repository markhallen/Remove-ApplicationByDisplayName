class CommandString {
    [String]$Command

    CommandString([String]$Command)
    {
        $this.Command = $Command
    }

    [String] ToUninstall()
    {
        $Result = $this
        $Result.Command = $Result.CaseInsensitiveReplace(" /install"," /uninstall")
        $Result.Command = $Result.CaseInsensitiveReplace(" /modify"," /uninstall")
        $Result.Command = $Result.CaseInsensitiveReplace(" /i "," /x ")
        $Result.Command = $Result.CaseInsensitiveReplace(" /f "," /x ")

        $Result.Command = $Result.Append(" /quiet")
        $Result.Command = $Result.Append(" /norestart")

        Return $Result.Command
    }

    [String] CaseInsensitiveReplace($Find,$Replace)
    {
        $Result = $this.Command
        if($Result.ToLower().Contains($Find)) {
            $Result =  [Regex]::Replace(`
                                    $Result, `
                                    [regex]::Escape($Find), `
                                    $Replace, `
                                    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase);
        }
        Return $Result
    }

    [String] Append($Postfix)
    {
        $Result = $this.Command
        if(!($Result.ToLower().Contains($Postfix))) { $Result = $Result + $Postfix }
        Return $Result
    }
}