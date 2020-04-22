# PowerShell Script

個人使用的 PowerShell Script

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

## 撰寫模組

正規方式請參考官方文件[如何撰寫 PowerShell 指令碼模組](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/module/how-to-write-a-powershell-script-module)，但這裡使用特殊作法，來做到簡便的模組化開發，請參考 [PowerShell Import-Module with .ps1 quirk](https://gist.github.com/magnetikonline/2cdbfe45258c0cc3cf1530548baf30a7) 這邊說明。

### 撰寫流程範例

在 `modules` 資料夾下建立 `demo-module.ps1` 腳本，並撰寫所要提供的 cmdlet 方法，如下：

```ps1
function Show-Demo() {
    Write-Output "Demo"
}
```

在要使用 `demo-module.ps1` 腳本所提供的 cmdlet 方法的腳本檔案上方，使用以下方式載入：

```ps1
Import-Module -Name ($PSScriptRoot + "\modules\demo-module.ps1")
```

>請注意載入檔案的相對路徑。

這樣就可以使用 `Show-Demo` cmdlet 方法。
