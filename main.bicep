@description('Deployment prefix for naming resources.')
param deploymentPrefix string

@description('Location for Azure resources.')
param location string

var logicAppName = 'logic-app-test'

module logicApp './LogicApp/main.bicep' = {
  name: '${deploymentPrefix}-logicApp'
  params: {
    location: location
    // enableSystemAssignedManagedIdentity: true
    logicAppName: logicAppName
    workflowDefinition: {}
    workflowParameters: {}
  }
}
