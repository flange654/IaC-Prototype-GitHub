@description('Name of the Logic App')
param logicAppName string

@description('Deployment location (e.g., eastus, westus, etc.)')
param location string

@description('State of the Logic App (Enabled/Disabled)')
param logicAppState string = 'Enabled'

@description('Workflow definition in JSON format')
param workflowDefinition object

@description('Workflow parameters in JSON format')
param workflowParameters object

// @description('Enable System-Assigned Managed Identity (true/false)')
// param enableSystemAssignedManagedIdentity bool = false

// @description('Enable User Assigned Managed Identity (true/false)')
// param enableUserAssignedManagedIdentity bool = false

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  // identity: enableSystemAssignedManagedIdentity ? {type: 'SystemAssigned'} : enableUserAssignedManagedIdentity ? {type: 'UserAssigned'} : null
  properties: {
    state: logicAppState
    definition: workflowDefinition
    parameters: !empty(workflowParameters) ? workflowParameters : null
  }
}

output logicAppId string = logicApp.id
output logicAppName string = logicApp.name
output logicAppState string = logicApp.properties.state
output logicAppPrincipalId string = logicApp.identity.principalId
