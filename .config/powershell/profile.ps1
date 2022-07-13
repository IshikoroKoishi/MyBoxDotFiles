function MyGetGitStatus {
    if (Test-Path ".git") {
        if (Get-Command "git" -ea SilentlyContinue) {
            return "<" + (git symbolic-ref --short HEAD) + ">"
        }
    }
    return ""
}


function prompt {
    $Sep = [IO.Path]::DirectorySeparatorChar
    $CurrentDir = (Convert-Path .)
    if ($CurrentDir.Contains($HOME)) {
        $CurrentDir = $CurrentDir.Replace($HOME, "~")
    }
    $PArry = $CurrentDir.Split($Sep)
    $Len = $PArry.Count - 1
    $Idx = 0
    $NArry = @()
    foreach ($P in $PArry) {
        if (($Idx -lt $Len) -and ($P -notmatch "[A-Z]+:")) {
            $NArry += $P.Substring(0, 1)
        } else {
            $NArry += $P
        }
        $Idx = $Idx + 1
    }
    $CurrentDir = [String]::Join($Sep, $NArry)

    Write-Host -ForegroundColor Cyan -NoNewline ("[" + (Get-Date -Format 'yyyy/MM/dd(ddd)HH:mm:ss') + "] ")
    Write-Host -ForegroundColor Green -NoNewline ([Environment]::UserName + "@")
    Write-Host -ForegroundColor Cyan -NoNewline ((HostName) + " ")
    Write-Host -ForegroundColor Cyan -NoNewline (" " + $CurrentDir + " ")
    Write-Host -ForegroundColor Green (MyGetGitStatus)
    $CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return "# "
    } else {
        return "$ "
    }
}
