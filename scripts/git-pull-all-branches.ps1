<#
根據指定的跟目錄，找出底下有哪些資料夾是 Git 專案，並自動 Pull 專案中所有分支至本機
#>

Import-Module -Name "..\modules\output-module.ps1"

function Receive-AllBranches() {
    $branches = git branch
    foreach ($branch in $branches) {
        $fixedBranch = $branch.Substring(2, $branch.Length - 2)
        $trackedExpression = "branch." + $fixedBranch + ".merge"
        $trackedBranch = git config --get $trackedExpression
        #  Write-Host($trackedBranch)
        if (![string]::IsNullOrEmpty($trackedBranch)) {
            Write-ColorOutput yellow "Pulling branch: $($fixedBranch)"
            git checkout "$fixedBranch" | Out-Null
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

    foreach ($folder in $folders) {
        if (![string]::IsNullOrEmpty($folder)) {
            Write-Host("Change to folder '" + $folder + "'")
            Set-Location -Path $folder
            Receive-AllBranches
            Move-DevelopBranch
        }
    }
}

Start-PullAllBranches