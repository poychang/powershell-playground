# 基本範例
# --------------------------------------------------
Invoke-RestMethod 'http://API_URL' `
    -Method 'POST' `
    -Headers @{ "Content-Type" = "application/json"; } `
    -Body "{`"Name`":`"Poy Chang`",`"Age`":`"23`"}"

# 連續呼叫 HTTP API
# --------------------------------------------------
$url = "http://API_URL"
$authResponse = Invoke-RestMethod -Method 'GET' $url
# 設定 HTTP Request Header
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("AccessToken", $authResponse.AccessToken)
Invoke-RestMethod "$($url)/Reminder" -Method 'GET' -Headers $headers
