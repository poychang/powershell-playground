# REF: ForEach-Object
# https://docs.microsoft.com/zh-tw/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.1

# Example 1
$Array = @(
    'Value1',
    'Value2',
    'Value3'
)
$Array | ForEach-Object -Parallel {
    $now = Get-Date
    Write-Host "$now $_"
    Start-Sleep 1
} -ThrottleLimit 2

# Example 2
1..3 | ForEach-Object -Parallel {
    $now = Get-Date
    Write-Host "$now $_"
    Start-Sleep 1
} -ThrottleLimit 2

# Example 3 若需要用到外部的變數，可使用 $using: 來取得
$Message = "Output:"
1..3 | ForEach-Object -Parallel {
    "$using:Message $_"
    Start-Sleep 1
} -ThrottleLimit 2
