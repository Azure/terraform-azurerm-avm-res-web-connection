output "name" {
  description = "The name of the API Connection."
  value       = azurerm_api_connection.this.name
}

output "resource" {
  description = "The API Connection resource."
  value       = azurerm_api_connection.this
}

output "resource_id" {
  description = "The ID of the API Connection."
  value       = azurerm_api_connection.this.id
}
