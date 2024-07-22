param resourceName string
param location string =resourceGroup().location

resource Container 'Microsoft.ContainerInstance/containerGroups@2023-05-01' ={
  name:resourceName
  location:location
  properties:{
    containers:[
      {
        name:'hello-world'
        properties:{
          image:'mcr.microsoft.com/azuredocs/aci-helloworld'
          ports:[
            {port:80 }
            {port:8080}
           ]
          resources:{
            requests:{ 
              cpu:1
              memoryInGB:2
            }
          }
        }
      }
      {
        name:'sidebar'
        properties:{
          image:'mcr.microsoft.com/azuredocs/aci-tutorial-sidebar'
         
          resources:{
            requests:{ 
              cpu:1
              memoryInGB:2
            }
          }
        }
      }
    ]
    osType:'Linux'
    restartPolicy:'Always'
    ipAddress:{ 
      type:'Public'
      ports:[
        {
          port:80
          protocol:'TCP'

        }
         {
          port:80
          protocol:'TCP'

        }
      ]
    }
  }
}
output containerIp string = Container.properties.ipAddress.ip
