# PowerShell Script

個人使用的 PowerShell Script

## 常用的 Cmdlet

| Cmdlet            | 說明                   | 文件  |
| ----------------- | --------------------- | ----- |
| `Write-Output`    | 輸出結果               | [Doc](https://docs.microsoft.com/zh-tw/powershell/module/microsoft.powershell.utility/write-output) |
| `ConvertTo-Json`  | 將物件轉成 JSON 格式輸出 | |
| `New-item`        | 輸出至檔案              | |

## 匿名物件

```ps1
$Obj = @{ 'Key' = 'Value'; }
ConvertTo-Json $Obj # 轉成 JSON 字串
```

## 參考資料

### 動詞

PowerShell 命令的已核准動詞請參考[此官方文件](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands)，部分動詞清單如下：

- [一般動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#common-verbs)
  - Add
  - Get
  - Move
  - New
  - Search
  - Select
  - Set
  - Show
- [通訊動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#communications-verbs)
  - Connect
  - Disconnect
  - Read
  - Receive
  - Send
  - Write
- [資料動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#data-verbs)
- [診斷動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#diagnostic-verbs)
- [生命週期動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#lifecycle-verbs)
- [安全性動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#security-verbs)
- [其他動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#other-verbs)
  - Use

### 比較運算子

| 運算子            | 描述                      | 範例                     |
| ---------------- | ------------------------- | ----------------------- |
| `eq`（等於）      | 比較兩個值是否相等           | `A -eq B` 結果為 `false` |
| `ne`（不等於）    | 比較兩個值不相等             | `A -ne B` 結果為 `true`  |
| `gt`（大於）      | 比較第一個值大於第二個值      | `B -gt A` 結果為 `true`  |
| `ge`（大於或等於） | 比較第一個值大於或等於第二個值 | `B-A` 結果為 `true`      |
| `lt`（小於）      | 比較第一個值小於第二個值      | `B -lt A` 結果為 `false` |
| `le`（小於或等於） | 比較第一個值小於或等於第二個值 | `B -le A` 結果為 `true`  |

### 執行原則

使用 `Get-ExecutionPolicy` cmdlet 來確認系統目前的指令檔執行限制，使用 `Set-ExecutionPolicy Unrestricted` cmdlet 可將指令檔的執行原則改為 `Unrestricted`。

- `Restricted`：關閉指令檔的執行功能，這是預設的設定值
- `AllSigned`：只允許執行受信任發行者簽署過的指令檔
- `RemoteSigned`：在本機電腦所撰寫的指令檔，不需要簽署就可執行；但是從網際網路（例如：email、MSN Messenger）下載的指令檔就必須經過受信任發行者的簽署才能執行
- `Unrestricted`：任何指令檔皆可被執行，但是於執行網際網路下載的指令檔時，會先出現警告的提示視窗

>在正式環境建議將指令檔的執行原則改成 `RemoteSigned`，個人開發環境使用 `Unrestricted` 可方便測試所撰寫的指令檔。

## 撰寫模組

正規方式請參考官方文件[如何撰寫 PowerShell 指令碼模組](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/module/how-to-write-a-powershell-script-module)，但這裡使用特殊作法，來做到簡便的模組化開發，請參考 [PowerShell Import-Module with .ps1 quirk](https://gist.github.com/magnetikonline/2cdbfe45258c0cc3cf1530548baf30a7) 這邊說明。

### 撰寫流程範例

在 `modules` 資料夾下建立 `demo-module.ps1` 腳本，並撰寫所要提供的 cmdlet 方法，如下：

```ps1
function Show-Demo() {
    Write-Output "Demo"
}
```

在要使用 `demo-module.ps1` 腳本所提供的 cmdlet 方法的指令檔案上方，使用以下方式載入：

```ps1
Import-Module -Name ($PSScriptRoot + "\modules\demo-module.ps1")
```

>請注意載入檔案的相對路徑。

這樣就可以使用 `Show-Demo` cmdlet 方法。

### 管線變數

PowerShell 很多 Cmdlet 指令可以使用 `|` 管線符號來連接另一個 Cmdlet，將前一個 Cmdlet 所輸出的結館傳遞給下一個 Cmdlet，同時也可以使用 `$_` 或 `$PSItem` （這兩個是一樣的東西）來取得上一個 Cmdlet 所輸出的結果。

下面的範例會輸出一樣的結果：

```ps1
Get-ChildItem -Path C:\Windows\ -Directory | ForEach-Object { $_.Name }
Get-ChildItem -Path C:\Windows\ -Directory | ForEach-Object { $PSItem.Name }
```
