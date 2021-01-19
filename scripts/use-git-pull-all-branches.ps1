<#
根據指定的根目錄，找出底下有哪些資料夾是 Git 專案，並自動 Pull 專案中所有分支至本機
#>

Import-Module "..\modules\output-module.psm1"

function Receive-AllBranches() {
    # 取得所有分支名稱
    $branches = git branch

    # 逐一處理每個分支
    foreach ($branch in $branches) {
        # 整理一下分支名稱，移除前面 2 個不需要的字元
        $fixedBranch = $branch.Substring(2, $branch.Length - 2)
        
        # 檢查是否有設定遠端分支
        $trackedExpression = "branch." + $fixedBranch + ".merge"
        $trackedBranch = git config --get $trackedExpression
        #  Write-Host($trackedBranch)
        if (![string]::IsNullOrEmpty($trackedBranch)) {
            Write-ColorOutput yellow "Pulling branch: $($fixedBranch)"
            # 切換分支
            git checkout "$fixedBranch" | Out-Null
            # 同步遠端分支
            git pull 
        }
        else {
            Write-ColorOutput red "Branch '$($fixedBranch)' has no tracked remote"
        }
    }
}

function Move-DevelopBranch() {
    $developBranch = git branch | Foreach-Object {
        $fixedBranch = $_.Substring(2, $_.Length - 2)
        if ($fixedBranch.StartsWith("d", "CurrentCultureIgnoreCase")) {
            Write-Output $fixedBranch
        }
    }
    if (![string]::IsNullOrEmpty($developBranch)) {
        Write-ColorOutput green "Checkout '$($developBranch)' branch"
        git checkout "$developBranch" | Out-Null
    }
}

function Start-PullAllBranches() {
    # 指定跟目錄位置
    $target_location = "C:\Users\poychang\Code\Kingston"
    Set-Location -Path $target_location
    
    # 找出是 Git 專案的子資料夾路徑
    $folders = Get-ChildItem -Recurse -Depth 1 -Directory -Force -Filter .git | Foreach-Object {
        Write-Output $_.FullName.Replace(".git", [string]::Empty)
    }
    Write-ColorOutput green $folders
    Write-ColorOutput green "Here has $($folders.Length) projects ------------------------------"

    # 逐一處理每個 Git 專案資料夾
    foreach ($folder in $folders) {
        if (![string]::IsNullOrEmpty($folder)) {
            Write-Host("Change to folder '" + $folder + "'")
            Set-Location -Path $folder
            # 執行同步遠端分支的功能
            Receive-AllBranches
            # 切換回開發分支
            Move-DevelopBranch
        }
    }
}

Start-PullAllBranches