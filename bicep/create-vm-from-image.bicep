/*
Purpose:
Deploy a Windows VM from an existing Azure Compute Gallery Golden Image.

Prerequisites:
1. Existing Resource Group
2. Existing VNet
3. Existing Subnet
4. Existing Azure Compute Gallery image version
5. VM region must match image region

Update values during deployment:
- resource group name: in Azure CLI command
- location
- vmName
- vmSize
- vnetName
- subnetName
- adminUsername
- imageId
- adminPassword: enter securely at runtime, do not hardcode
*/

param location string = 'centralindia'

param vmName string = 'vm3-bicep'

param vmSize string = 'Standard_D2s_v3'

param vnetName string = 'vnet-infra'

param subnetName string = 'subnet-vm'

param adminUsername string

@secure()
param adminPassword string

param imageId string

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' existing = {
  parent: vnet
  name: subnetName
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: '${vmName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    storageProfile: {
      imageReference: {
        id: imageId
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }

    securityProfile: {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
    }
  }
}
// Output message after deployment completes
output deploymentStatus string = '${vmName} is built successfully'

// Output VM name
output createdVmName string = vm.name

// Output Public IP resource name
output publicIpName string = publicIp.name