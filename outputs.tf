output "resource_group_name" {
  value = azurerm_resource_group.render_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.render_storage.name
}

output "vnet_id" {
  value = azurerm_virtual_network.render_vnet.id
}