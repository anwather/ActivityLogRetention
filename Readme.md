# Activity Log Retention #

These templates will help deploy a log analytics workspace to a customer tenant, then help deploy activity log settings to each subscription.

# Instructions to deploy tenant workspace #

For each customer tenant that you want to deploy to log in and set the context to one of their subscriptions using ```Set-AzContext -Subscription "subscriptionId"```

Modify the ```workspace.parameters.json``` file and fill in the values for ```workspaceName``` - it must be globally unique.
You can also set the Log Analytics workspace retention by modifying the ```retentionInDays``` parameters value. 

```
"workspaceName": {
    "value": "" # <-- Modify this value
}
```
Deploy the template using the code below.

```
New-AzDeployment -Name deploy-workspace -Location australiaeast -TemplateFile .\workspace.json -TemplateParameterFile .\workspace.parameters.json -Verbose
```
In the output - retrieve the value of the workspace ID as it will be used for the next deployment.

Example Output:
```
Outputs                 :
    Name             Type                       Value
    ===============  =========================  ==========
    workspaceId      String
    /subscriptions/f333739a-1faa-4c65-8fc7-a6e0a2317723/resourceGroups/csp-log-analytics/providers/Microsoft.OperationalInsights/workspaces/aw-csp-ee1 #<-- Need this value
```
# Instructions to deploy activity log settings per subscription #

If not using Azure Lighthouse this needs to be performed for each customer subscription

Modify the ```activitylog.parameters.json``` file and fill in the values for ```workspaceId``` using the value from the previous deployment, and also modify the retention settings to the desired value (maximum of 730).

```
"workspaceId": {
    "value": "/subscriptions/f333739a-1faa-4c65-8fc7-a6e0a2317723/resourceGroups/csp-log-analytics/providers/Microsoft.OperationalInsights/workspaces/aw-csp-ee1"
},
"retentionInDays": {
    "value": 730
}
```

For each customer subscription use the code below to deploy the activity log settings.

```
Set-AzContext -Subscription "xx subscription id xx"
New-AzDeployment -Name deploy-activitylog-settings -Location australiaeast -TemplateFile .\activitylog.json -TemplateParameterFile .\activitylog.parameters.json -Verbose
```

Disclaimer
The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
