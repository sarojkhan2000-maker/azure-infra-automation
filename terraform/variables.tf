# Azure region
variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "centralindia"
}

# Resource Group name
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "rg-terraform-lab"
}

# VNet name
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "vnet-terraform"
}

# Subnet name
variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "subnet-terraform"
}

# NSG name
variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
  default     = "nsg-terraform"
}