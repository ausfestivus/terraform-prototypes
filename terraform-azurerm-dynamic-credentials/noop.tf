data "azurerm_client_config" "current" {
}

output "azurerm_client_id" {
  value = "client_id:       ${data.azurerm_client_config.current.client_id}"
}

output "azurerm_tenant_id" {
  value = "tenant_id:       ${data.azurerm_client_config.current.tenant_id}"
}

output "azurerm_subscription_id" {
  value = "subscription_id: ${data.azurerm_client_config.current.subscription_id}"
}

output "azurerm_object_id" {
  value = "object_id:       ${data.azurerm_client_config.current.object_id}"
}
