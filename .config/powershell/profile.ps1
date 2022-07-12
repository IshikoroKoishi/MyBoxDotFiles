function prompt {
    $Sep = "/"
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
    $CurrentDir = [String]::Join($Sep, $NArryls
    )

    $RightSidePrompt = ("[" + (Get-Date -Format 'yyyy/MM/dd(ddd)HH:mm:ss') + "]")
    $StartPosX = $Host.UI.RawUI.WindowSize.Width - $RightSidePrompt.Length
    $StartPosY = $Host.UI.RawUI.CursorPosition.Y
    
    Write-Host -ForegroundColor Cyan -NoNewline ([Environment]::UserName + "@")
    Write-Host -ForegroundColor Red -NoNewline (hostname)
    Write-Host -NoNewline (" ")
    Write-Host -ForegroundColor Red -NoNewline ($CurrentDir)
    $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $StartPosX, $StartPosY
    $Host.UI.RawUI.ForegroundColor = "Red"
    $Host.UI.Write($RightSidePrompt)
    return "$ "
}
