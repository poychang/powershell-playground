# 列出目前已安裝的 SDK 版本
dotnet --list-sdks

$installDir = "C:\dotnet"
$versions = @("6.0", "7.0", "8.0", "9.0", "10.0")

# 下載 dotnet-install
$installer = "$env:TEMP\dotnet-install.ps1"
if (-not (Test-Path $installer)) {
    Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile $installer
}

# 更新 .NET SDK 至最新版本
foreach ($major in $versions) {
    Write-Host "=== Updating .NET SDK $major.x ==="

    $url = "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/$major/releases.json"
    $json = Invoke-WebRequest -Uri $url -UseBasicParsing | ConvertFrom-Json
    $latest = $json."latest-sdk"
    Write-Host "Latest SDK for $major = $latest"
    Write-Host "Installing by $installer"
    & $installer -Version $latest -Verbose
}
