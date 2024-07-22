param location string = resourceGroup().location
param storageAccountName string = 'storage1'


module storageAccount 'storageAccount.bicep'={
  name:'storage_account'
   params:{location:location 
  storageAccountName:storageAccountName}}
resource userAssigned 'Microsoft.ManagedIdentity/userAssignedIdentities@2021-08-01-preview' = {
  location: location
  name: 'xxxxx'
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2021-04-01' = {
  name: guid(resourceGroup().id, 'contributor')
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
    principalId: userAssigned.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2021-08-01' = {
  name: 'deploymentScript'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssigned.id}': {}
    }
  }
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: '''
    $output = ' '
    write-output $output
    $deploymentScriptOutput = @{}
    $deploymentScriptOutput['text'] = $output
    '''
    retentionInterval: 'P1D'
  }
}

output accountName string = storageAccountName
output ScriptResult string = deploymentScript.properties.outputs['text']
