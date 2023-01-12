# PowerShell

個人使用的 PowerShell Script

## PowerShell 檔案類型

REF: [What are the different PowerShell file types?](https://stackoverflow.com/questions/62604621/what-are-the-different-powershell-file-types)

- `.ps1` 是 PowerShell 腳本的檔案類型，它包含了 PowerShell 指令碼，可以在 PowerShell 中執行，如同 `.sh`、`.bat` 這類的腳本檔
- `.psm1` 是 PowerShell 模組的檔案類型，它包含了封裝好的 PowerShell 函式或 cmdlet 指令碼，可以在 PowerShell 中使用 `Import-Module` 指令載入並使用
  - Other `Module-Interaction` cmdlets:
    - `Export-ModuleMember`
    - `Find-Module`
    - `Get-InstalledModule`
    - `Get-Module`
    - `ImportSystemModules`
    - `New-Module`
    - `New-ModuleManifest`
    - etc, tab through `*Module*` in PowerShell
- `.psd1` 是 PowerShell 模組設定檔的檔案類型，它包含了模組相關的元數據信息，如模組名稱、版本、依賴性等。這些元數據會被 PowerShell 用來檢查模組的有效性和可用性，更多關於此檔案類型的資訊請參考[如何撰寫 PowerShell 模組資訊清單](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest)
  - Manipulated with
    - `Import-PowerShellDataFile`
    - `New-ModuleManifest`
    - `Test-ModuleManifest`
    - `Update-ModuleManifest`
    - `Import-LocalizedData`

## 常用的 Cmdlet

| Cmdlet             | 說明             | 文件                                                                                                     |
| ------------------ | ---------------- | -------------------------------------------------------------------------------------------------------- |
| `Write-Output`     | 輸出結果         | [Docs](https://docs.microsoft.com/zh-tw/powershell/module/microsoft.powershell.utility/write-output)     |
| `ConvertTo-Json`   | 物件轉 JSON 格式 |                                                                                                          |
| `ConvertFrom-Json` | JSON 轉物件格式  | [Docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json) |
| `New-item`         | 輸出至檔案       |                                                                                                          |

## 匿名物件

```ps1
$Object = @{ 'Key' = 'Value'; }
# 比較嚴謹的寫法，在前面加 [PSCustomObject]
# $Object = [PSCustomObject]@{ 'Key' = 'Value'; }
ConvertTo-Json $Object # 轉成 JSON 字串

$Array = @(
  @{ 'Key' = 'Value1'; },
  @{ 'Key' = 'Value2'; }
)
ConvertTo-Json $Array # 轉成 JSON 字串
```

## 參考資料

Visual Studio Code 的 [PowerShell 擴充套件](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)附帶一些範例程式碼，路徑為：

```
$HOME/.vscode[-insiders]/extensions/ms-vscode.PowerShell-<version>/examples
```

可以在 PowerShell 中使用下列指令用 Visual Studio Code 開啟：

```powershell
code (Get-ChildItem $Home\.vscode\extensions\ms-vscode.PowerShell-*\examples)[-1]
```

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
  - Backup
  - Checkpoint
  - Compare
  - Compress
  - Convert
  - ConvertFrom
  - ConvertTo
  - Dismount
  - Edit
  - Expand
  - Export
  - Import
  - Initialize
  - Limit
  - Merge
  - Mount
  - Out
  - Publish
  - Restore
  - Save
  - Sync
  - Unpublish
  - Update
- [診斷動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#diagnostic-verbs)
  - Debug
  - Measure
  - Repair
  - Resolve
  - Test
  - Trace
- [生命週期動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#lifecycle-verbs)
  - Approve
  - Assert
  - Build
  - Complete
  - Confirm
  - Deny
  - Deploy
  - Disable
  - Enable
  - Install
  - Invoke
  - Register
  - Request
  - Restart
  - Resume
  - Start
  - Stop
  - Submit
  - Suspend
  - Uninstall
  - Unregister
  - Wait
- [安全性動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#security-verbs)
  - Block
  - Grant
  - Protect
  - Revoke
  - Unblock
  - Unprotect
- [其他動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands#other-verbs)
  - Use

### 比較運算子

| 運算子             | 描述                           | 範例                     |
| ------------------ | ------------------------------ | ------------------------ |
| `eq`（等於）       | 比較兩個值是否相等             | `A -eq B` 結果為 `false` |
| `ne`（不等於）     | 比較兩個值不相等               | `A -ne B` 結果為 `true`  |
| `gt`（大於）       | 比較第一個值大於第二個值       | `B -gt A` 結果為 `true`  |
| `ge`（大於或等於） | 比較第一個值大於或等於第二個值 | `B-A` 結果為 `true`      |
| `lt`（小於）       | 比較第一個值小於第二個值       | `B -lt A` 結果為 `false` |
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
