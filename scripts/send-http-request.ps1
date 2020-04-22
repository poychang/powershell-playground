<#
使用 Invoke-WebRequest 發送訊息到 Teams Channel
#>

Import-Module "..\modules\output-module.psm1"

$exitCode = 1

try {
    if ($null -ne $args[0]) {
        $targetUrl = $args[0]
    }
    else {
        # 測試用的 Teams Channel Webhook URL
        $targetUrl = "https://outlook.office.com/webhook/70ed5294-ddfb-4eab-9be5-6a8c430661e2@f43a2d89-bcd5-425f-981c-f7231bcd4467/IncomingWebhook/7f6df48fc07849fc917f557f719b569d/3098eded-4c4c-498b-8619-90a141fc88c7"
    }

    Write-ColorOutput green "Sending request to $targetUrl"

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
    
    $Response = Invoke-WebRequest $targetUrl -SessionVariable 'Session' -Body $Body -Method 'POST'
    $StatusCode = $Response.StatusCode
    $exitCode = 0
}
catch {
    $StatusCode = 400
    $exitCode = 1
}

$StatusCode
exit $exitCode