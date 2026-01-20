variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "render-farm-rg"
}

variable "location" {
  description = "Azure region where resources will be created"
  default     = "Norway East"
}

variable "vm_sku" {
  description = "Size of the virtual machines"
  default     = "Standard_DS1_v2"
}