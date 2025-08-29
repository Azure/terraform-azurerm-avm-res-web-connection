resource "azurerm_api_connection" "this" {
  managed_api_id      = var.managed_api_id
  name                = var.name
  resource_group_name = var.resource_group_name
  display_name        = var.display_name
  parameter_values    = var.parameter_values
  tags                = var.tags
}
