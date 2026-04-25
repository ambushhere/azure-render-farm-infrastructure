variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "render-farm-rg"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "Norway East"
}

variable "vm_sku" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "vmss_instances" {
  description = "Number of VM scale set instances"
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Admin username for VM scale set instances"
  type        = string
  default     = "renderadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used for admin access to VM scale set"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "Development"
}
