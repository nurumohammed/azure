param location string = resourceGroup().location
param storageAccountName string = 'storage1'
 var tables = [
  'tabel1' 
  'table2'
]
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  tags: {
    environment: 'dev'
    business_unit: 'connectivity'
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
resource storageAccountTableService 'Microsoft.Storage/storageAccounts@2023-05-01' ={
  name:'default'
  dependsOn:[storageAccount]
}

resource storageAccountTable 'Microsoft.Storage/storageAccounts@2023-05-01' ={
  name:'table'
  dependsOn:[storageAccount]
}



