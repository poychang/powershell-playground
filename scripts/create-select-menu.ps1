function Show-Menu {
    Write-Host "--------Select Menu--------"
    Write-Host "1: Press '1' for this option."
    Write-Host "2: Press '2' for this option."
    Write-Host "3: Press '3' for this option."
    Write-Host "Q: Press 'Q' to quit."
}

function Select-Menu {
    do {
        Clear-Host
        Show-Menu
        $Selection = Read-Host "Please make a selection"
        switch ($Selection) {
            'A' { Write-Host "A" }
            'B' { Write-Host "B" }
            'C' { Write-Host "C" }
            'Q' { return }
        }
        pause
    }
    until($Selection -eq 'Q')
}

Select-Menu