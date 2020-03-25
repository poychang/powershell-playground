$target_location = "C:\Users\poychang\Code\Kingston"
$target_location = "C:\Users\poychang\Code\github\powershell-script\"
Set-Location -Path $target_location

$folder_list = Get-ChildItem -Recurse -Depth 1 -Directory -Force -Filter .git | Foreach-Object {
    Write-Output $_.FullName.Replace('.git', '')
}

Write-Output "-------------";
# Write-Output $folder_list;

Get-Content $folder_list | Foreach-Object {
    Write-Output $_;
}
