@description('Deployment prefix for naming resources.')
param deploymentPrefix string

@description('Location for Azure resources.')
param location string

var logicAppName = 'logic-app-test-via-github'

var workflowDefinition = {
  '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
  contentVersion: '1.0.0.0'
  parameters: {}
  triggers: {}
  actions: {}
  outputs: {}
}

module logicApp './LogicApp/main.bicep' = {
  name: '${deploymentPrefix}-logicApp'
  params: {
    location: location
    // enableSystemAssignedManagedIdentity: true
    logicAppName: logicAppName
    workflowDefinition: workflowDefinition
    workflowParameters: {}
  }
}
