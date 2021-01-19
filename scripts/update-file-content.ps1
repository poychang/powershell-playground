<#
根據指定的根目錄找出底下所有檔案，並將所有檔案內的某字串替換掉

Update-FileContent -Path C:\Users\poychang\Downloads\Test\ -Search "\ufeff" -Value "" -Verbose
#>

function Update-FileContent {
    Param(
        [Parameter(
            Mandatory = $true,
            Position = 0,
            HelpMessage = "Folder path"
        )]
        [string]$Path,
        [Parameter(
            Mandatory = $true,
            Position = 1,
            HelpMessage = "Search content"
        )]
        [string]$Search,
        [Parameter(
            Mandatory = $true,
            Position = 2,
            HelpMessage = "Replace to"
        )]
        [AllowEmptyString()]
        [string]$Value
    )

    $files = Get-ChildItem -Path $Path -File
    foreach ($file in $files) {
        Write-Verbose -Message "Replace From: $file.FullName"
        ((Get-Content -path $file.FullName -Raw) -replace $Search, $Value) | Set-Content -Path $file.FullName -Encoding unicode
    }
}
