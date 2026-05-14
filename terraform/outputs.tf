# Output Resource Group name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# Output VNet name
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

# Output Subnet name
output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

# Output NSG name
output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}