<#
將 Windows 預設輸入法改成以 ENG (英文) 為主要輸入法，此模式很建議開發者使用
#>

$UserLanguageList = New-WinUserLanguageList -Language "zh-TW"
$UserLanguageList.Add("en-US")
Set-WinUserLanguageList -LanguageList $UserLanguageList -Force
Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"
