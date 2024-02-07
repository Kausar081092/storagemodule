terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
 
}

provider "azurerm" {
features {}
}




resource "random_string" "kau" {
  length           = 10
  special          = false
  upper = false
}

resource "azurerm_resource_group" "module_RG"{
    name =var.resource_group_name
    location=var.location
}
resource "azurerm_storage_account" "kaust_new" {
  name                     = "${var.storage_account_name}${random_string.kau.id}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

    static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
  depends_on = [azurerm_resource_group.module_RG]
}

# Output variable definitions
output "resource_group_id" {
  description = "resource group id"
  value       = azurerm_resource_group.module_RG.id
}
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.module_RG.name
}
output "resource_group_location" {
  description = "resource group location"
  value       = azurerm_resource_group.module_RG.location
}
output "storage_account_id" {
  description = "storage account id"
  value       = azurerm_storage_account.kaust_new.id
}
output "storage_account_name" {
  description = "storage account name"
  value       = azurerm_storage_account.kaust_new.name
}


