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

Add-DynamicFunction -FuncName 'Hello-Dynamic-Function' -FuncAction 'Write-Output "Hello-Dynamic-Function..."'
Hello-Dynamic-Function

