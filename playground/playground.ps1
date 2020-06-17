Import-Module -Name "..\modules\output-module.psm1"

Write-ColorOutput green "Hello"
Write-ColorOutput yellow "Hello"
Write-ColorOutput red "Hello"

Write-Host "---------- Direct to Host ----------"

Write-Output "Output"
Write-Warning "Warning"
Write-Error "Error"
