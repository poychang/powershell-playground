$list = `
    ([PSCustomObject]@{ Name="A1"; Role="2"; Description="3" }), `
    ([PSCustomObject]@{ Name="B1"; Role="2"; Description="3" }), `
    ([PSCustomObject]@{ Name="C1"; Role="2"; Description="3" });

$list.ForEach({ Write-Output $_ })

$list.ForEach({ Write-Output "HI $ $($_.Name)" })

$list | ForEach-Object { Write-Output $_ }

foreach ($item in $list) { Write-Output $item }

#  建議使用 foreach 語法，因為清單變數自帶的 ForEach 方法、ForEach-Object Cmdlet 會使用 $_ 來取得當前資料，而 $_ 是參考內部的 Scope，比較容易出現不如預期的狀況，相對的第三種 foreach 語法則比較不容易有問題
