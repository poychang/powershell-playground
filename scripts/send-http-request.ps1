<#
使用 Invoke-RestMethod 發送訊息到 Teams Channel
Invoke-WebRequest Gets content from a web page on the Internet
Invoke-RestMethod Sends an HTTP or HTTPS request to a RESTful web service
#>

$exitCode = 1

try {
    if ($null -ne $args[0]) {
        $targetUrl = $args[0]
    }
    else {
        # 測試用的 Teams Channel Webhook URL
        $targetUrl = "https://outlook.office.com/webhook/70ed5294-ddfb-4eab-9be5-6a8c430661e2@f43a2d89-bcd5-425f-981c-f7231bcd4467/IncomingWebhook/7f6df48fc07849fc917f557f719b569d/3098eded-4c4c-498b-8619-90a141fc88c7"
    }

    Write-Output "Sending request to $targetUrl"
    $Headers = @{ 'Content-Type' = 'application/json'; }
    $Body = "{
        ""@type"": ""MessageCard"",
        ""@context"": ""http://schema.org/extensions"",
        ""themeColor"": ""0076D7"",
        ""summary"": ""Channl Test"",
        ""sections"": [
            {
                ""facts"": [
                    {
                        ""name"": ""Message"",
                        ""value"": ""This is a Channl Test""
                    }
                ],
                ""markdown"": true
            }
        ]
    }"
    
    $Response = Invoke-WebRequest $targetUrl -SessionVariable 'Session' -Method 'POST' -Headers $Headers -Body $Body
    Write-Output "StatusCode: $($Response.StatusCode)"
    Write-Output "Response: $($Response.Content)"
    $exitCode = 0
}
catch {
    Write-Output $Error[0]
    $exitCode = 1
}

exit $exitCode