terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    # modtm = {
    #   source  = "azure/modtm"
    #   version = "~> 0.3"
    # }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = "0.8.0"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
}

# This is required for resource modules
resource "azurerm_resource_group" "example" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

data "azurerm_managed_api" "example" {
  location = azurerm_resource_group.example.location
  name     = "azuremonitorlogs"
}

module "test" {
  source = "../../"

  managed_api_id      = data.azurerm_managed_api.example.id
  name                = module.naming.api_management.name_unique # TODO update with module.naming.<RESOURCE_TYPE>.name_unique
  resource_group_name = azurerm_resource_group.example.name
  display_name        = "Test API Connection"
  enable_telemetry    = var.enable_telemetry # see variables.tf
  parameter_values    = {}
  tags                = {}
}
