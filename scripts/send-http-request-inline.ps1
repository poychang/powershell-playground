Invoke-RestMethod 'http://API_URL' `
    -Method 'POST' `
    -Headers @{ "Content-Type" = "application/json"; } `
    -Body "{`"Name`":`"Poy Chang`",`"Age`":`"23`"}"
