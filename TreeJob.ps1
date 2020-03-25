<#
持續執行 tree /F 指令，觀察資料夾的檔案與資料夾目錄變化
預設會執行到中午 12 點
#>
function TreeJob($STOP_HOUR = 12) {
    Write-Output "Start...";

    do {
        $current_hour = [int] $(Get-Date -Format "HH");
        # $current_hour = [int] $(Get-Date -Format "mm"); # For testing
        Write-ColorOutput green "$(Get-Date -Format "HH:mm") ----------------------------------------";
        tree /F;
        Start-Sleep -s 2;
    } while ($current_hour -lt $STOP_HOUR)

    Write-Output "End...";
}

function Write-ColorOutput($ForegroundColor) {
    # 儲存當前顏色設定
    $fc = $host.UI.RawUI.ForegroundColor;
    # 設定新顏色
    $host.UI.RawUI.ForegroundColor = $ForegroundColor;
    # 輸出
    if ($args) {
        Write-Output $args;
    }
    else {
        $input | Write-Output;
    }
    # 還原原本的顏色設定
    $host.UI.RawUI.ForegroundColor = $fc;
}

# TreeJob;
TreeJob(12);
