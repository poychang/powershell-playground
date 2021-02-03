function ll { Get-ChildItem -Force }
function hello { Write-Output Hello $env:USERNAME }
function home { ($args.Count -eq 1) ? (Set-Location $env:USERPROFILE/$args) : (Set-Location $env:USERPROFILE) }
function showenv { Get-ChildItem env: }
function grep { $input | out-string -stream | select-string -pattern $args }
function e. { 
    if ($IsWindows) { explorer . }
    elseif ($IsMacOS) { open . }
}
