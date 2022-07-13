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
        if ($Idx -lt $Len) {
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
    Write-Host -ForegroundColor Cyan (" " + $CurrentDir)
    return "$ "
}