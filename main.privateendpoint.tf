# TODO remove this code & var.private_endpoints if private link is not support.  Note it must be included in this module if it is supported.
# resource "azurerm_private_endpoint" "this_managed_dns_zone_groups" {
#   for_each = var.private_endpoints

#   location                      = each.value.location != null ? each.value.location : var.location
#   name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
#   resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
#   subnet_id                     = each.value.subnet_resource_id
#   custom_network_interface_name = each.value.network_interface_name
#   tags                          = each.value.tags

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
#     private_connection_resource_id = azurerm_api_connection.this.id
#     subresource_names              = ["TODO subresource name, see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource"]
#   }
#   dynamic "ip_configuration" {
#     for_each = each.value.ip_configurations

#     content {
#       name               = ip_configuration.value.name
#       private_ip_address = ip_configuration.value.private_ip_address
#       member_name        = "TODO subresource name"
#       subresource_name   = "TODO subresource name"
#     }
#   }
#   dynamic "private_dns_zone_group" {
#     for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

#     content {
#       name                 = each.value.private_dns_zone_group_name
#       private_dns_zone_ids = each.value.private_dns_zone_resource_ids
#     }
#   }
# }

# The PE resource when we are managing **not** the private_dns_zone_group block
# An example use case is customers using Azure Policy to create private DNS zones
# e.g. <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale>
# resource "azurerm_private_endpoint" "this_unmanaged_dns_zone_groups" {
#   for_each = { for k, v in var.private_endpoints : k => v if !var.private_endpoints_manage_dns_zone_group }

#   location                      = each.value.location != null ? each.value.location : var.location
#   name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
#   resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
#   subnet_id                     = each.value.subnet_resource_id
#   custom_network_interface_name = each.value.network_interface_name
#   tags                          = each.value.tags

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
#     private_connection_resource_id = azurerm_api_connection.this.id
#     subresource_names              = ["TODO subresource name, see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource"]
#   }
#   dynamic "ip_configuration" {
#     for_each = each.value.ip_configurations

#     content {
#       name               = ip_configuration.value.name
#       private_ip_address = ip_configuration.value.private_ip_address
#       member_name        = "TODO subresource name"
#       subresource_name   = "TODO subresource name"
#     }
#   }

#   lifecycle {
#     ignore_changes = [private_dns_zone_group]
#   }
# }

# resource "azurerm_private_endpoint_application_security_group_association" "this" {
#   for_each = local.private_endpoint_application_security_group_associations

#   application_security_group_id = each.value.asg_resource_id
#   private_endpoint_id           = var.private_endpoints_manage_dns_zone_group ? azurerm_private_endpoint.this_managed_dns_zone_groups[each.value.pe_key].id : azurerm_private_endpoint.this_unmanaged_dns_zone_groups[each.value.pe_key].id
# }
