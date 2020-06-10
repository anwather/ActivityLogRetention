New-AzDeployment -Name deploy-workspace -Location australiaeast -TemplateFile .\workspace.json -TemplateParameterFile .\workspace.parameters.json -Verbose

New-AzDeployment -Name deploy-activitylog-settings -Location australiaeast -TemplateFile .\activitylog.json -TemplateParameterFile .\activitylog.parameters.json -Verbose