
Param(
    [string]$TemplateFilePath,
    [string]$Location,
    [switch]$WhatIf
)
Begin {
    $deploymentName = "Deploy_POC" + (Get-Date -Format "yyyyMMddHHmmss")
}

Process {
    # Define the parameter object
    $paramsObject = @{
        '$schema'        = "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
        contentVersion   = "1.0.0.0"
        parameters = @{
            deploymentPrefix  = @{
                value = (Get-Date -Format "yyyyMMddHHmmss")
            }
            location          = @{
                value = $Location
            }
        }
    }

    # Convert to JSON and save to a file
    $jsonParams = $paramsObject | ConvertTo-Json -Depth 10
    $jsonParams | Out-File -FilePath 'parameters.json'

    Write-Host "Parameters file generated: parameters.json"

    $command = "az deployment group  create --resource-group rg-my-playground --name `"$deploymentName`"" 
    $command += " --template-file `"$TemplateFilePath`" --parameters  `"@parameters.json`" --subscription adiZERO-POC"
    
    if ($WhatIf.IsPresent) {
        $command += " --what-if"
    }
    Write-Host $command
    Invoke-Expression $command
}

End {
    Write-Host "Deployment process completed."
}