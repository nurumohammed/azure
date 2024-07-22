param resourceName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01'={
  name: resourceName
  location:location
  sku:{
    name:'F1'

  }
}
resource appService 'Microsoft.Web/sites@2023-12-01' ={ 
  name:resourceName
  location:location
  properties:{serverFarmId:appServicePlan.id}
  resource container 'sourceControls' = {
    name: 'web'
    properties: {
      repoUrl:'https://github.com/Azure-Samples/html-docs-helloworld'
      branch:'master'
      isManualIntegration: true
    }
  }
}
