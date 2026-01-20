# 1. Terraform Configuration and Provider Setup
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 2. Resource Group: Logical container for all Render Farm assets
resource "azurerm_resource_group" "render_rg" {
  name     = var.resource_group_name
  location = var.location
}

# 3. Virtual Network: Isolated network environment for compute nodes
resource "azurerm_virtual_network" "render_vnet" {
  name                = "render-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.render_rg.location
  resource_group_name = azurerm_resource_group.render_rg.name
}

# 4. Subnet: Dedicated segment for the Rendering Scale Set
resource "azurerm_subnet" "render_subnet" {
  name                 = "render-nodes-subnet"
  resource_group_name  = azurerm_resource_group.render_rg.name
  virtual_network_name = azurerm_virtual_network.render_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 5. Storage Account: High-performance storage for 3D textures, assets, and output frames
resource "azurerm_storage_account" "render_storage" {
  name                     = "rendersdata${random_string.suffix.result}" # Ensures globally unique name
  resource_group_name      = azurerm_resource_group.render_rg.name
  location                 = azurerm_resource_group.render_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Random string helper to avoid naming conflicts in Azure Storage
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 6. Linux Virtual Machine Scale Set: The core compute engine of the farm
resource "azurerm_linux_virtual_machine_scale_set" "render_nodes" {
  name                = "render-nodes-set"
  resource_group_name = azurerm_resource_group.render_rg.name
  location            = azurerm_resource_group.render_rg.location
  sku                 = var.vm_sku # Defined in variables.tf
  instances           = 2
  admin_username      = "renderadmin"

  admin_password                  = "P@ssw0rd1234!" 
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interface {
    name    = "render-nic"
    primary = true
    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.render_subnet.id
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # Тэги должны быть ВНУТРИ фигурных скобок ресурса azurerm_linux_virtual_machine_scale_set
  tags = {
    Environment = "Development"
    Project     = "RenderFarm"
    CostCenter  = "3D-Production"
  }
} 