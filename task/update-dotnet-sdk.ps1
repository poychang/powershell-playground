# 列出目前已安裝的 SDK 版本
Write-Host "=== Checking installed .NET SDK versions ===" -ForegroundColor Cyan
$installedSdks = dotnet --list-sdks | ForEach-Object {
    if ($_ -match '^([\d\.]+)\s') {
        $matches[1]
    }
}
Write-Host "Installed SDKs: $($installedSdks -join ', ')" -ForegroundColor Gray

# 從已安裝的 SDK 中提取主要版本號
$installedMajorVersions = $installedSdks | ForEach-Object {
    if ($_ -match '^(\d+\.\d+)') {
        $matches[1]
    }
} | Select-Object -Unique | Sort-Object

if ($installedMajorVersions.Count -eq 0) {
    Write-Host "No .NET SDK installed. Nothing to update." -ForegroundColor Yellow
    exit
}

Write-Host "Found major versions to check: $($installedMajorVersions -join ', ')" -ForegroundColor Cyan

# 下載 dotnet-install
$installer = "$env:TEMP\dotnet-install.ps1"
if (-not (Test-Path $installer)) {
    Write-Host "Downloading dotnet-install script..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile $installer
}

# 更新 .NET SDK 至最新版本
foreach ($major in $installedMajorVersions) {
    Write-Host "`n=== Checking .NET SDK $major.x ===" -ForegroundColor Cyan

    try {
        $url = "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/$major/releases.json"
        $json = Invoke-WebRequest -Uri $url -UseBasicParsing | ConvertFrom-Json
        $latest = $json."latest-sdk"
        Write-Host "Latest available SDK for $major = $latest" -ForegroundColor Green
        
        # 檢查是否已安裝此版本
        $isInstalled = $installedSdks | Where-Object { $_ -eq $latest }
        
        if ($isInstalled) {
            Write-Host "✓ SDK $latest is already installed. Skipping." -ForegroundColor Green
        } else {
            # 檢查已安裝的同主版本
            $installedMajor = $installedSdks | Where-Object { $_ -like "$major.*" }
            Write-Host "Found older version(s): $($installedMajor -join ', ')" -ForegroundColor Yellow
            Write-Host "→ Updating to $latest..." -ForegroundColor Yellow
            
            & $installer -Version $latest
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✓ Successfully installed SDK $latest" -ForegroundColor Green
            } else {
                Write-Host "✗ Failed to install SDK $latest" -ForegroundColor Red
            }
        }
    }
    catch {
        Write-Host "✗ Failed to check or install .NET SDK $major.x" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== Update check completed ===" -ForegroundColor Cyan
