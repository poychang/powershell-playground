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
