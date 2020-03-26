<#
持續執行 tree /F 指令，觀察資料夾的檔案與資料夾目錄變化
預設會執行到中午 12 點
#>

Import-Module "..\modules\output-module.psm1"

function TreeJob($STOP_HOUR = 12) {
    Write-Output "Start..."

    do {
        $current_hour = [int] $(Get-Date -Format "HH")
        # $current_hour = [int] $(Get-Date -Format "mm") # For testing
        Write-ColorOutput green "$(Get-Date -Format "HH:mm") ------------------------------"
        tree /F
        Start-Sleep -s 2
    } while ($current_hour -lt $STOP_HOUR)

    Write-Output "End..."
}

# TreeJob
TreeJob(12)
