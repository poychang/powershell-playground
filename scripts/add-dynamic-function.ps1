<#
動態建立 Function
https://blog.poychang.net/dynamic-create-function-in-powershell/
#>

function Add-DynamicFunction {
    Param(
        [Parameter(
            Mandatory = $true,
            Position = 0,
            HelpMessage = "Function name"
        )]
        [string]$FuncName,
        [Parameter(
            Mandatory = $true,
            Position = 1,
            HelpMessage = "Function action"
        )]
        [string]$FuncAction
    )

    # Write-Output "function $($FuncName)() { $($FuncAction) }"
    Set-Variable -name Func -value "function global:$($FuncName)() { $($FuncAction) }"
    Invoke-Expression $Func
}

# 使用方式

Add-DynamicFunction -FuncName 'Hello-Dynamic-Function' -FuncAction 'Write-Output "Hello-Dynamic-Function..."'
Hello-Dynamic-Function
