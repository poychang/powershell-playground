# PowerShell Script

個人使用的 PowerShell Script

## 參考資料

- [PowerShell 命令的已核准動詞](https://docs.microsoft.com/zh-tw/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands)

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
