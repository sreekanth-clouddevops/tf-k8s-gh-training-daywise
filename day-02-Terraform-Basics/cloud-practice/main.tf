provider "azurerm" {
    features{}
    subscription_id = "292437ac-a0ee-42bf-9815-3ca12deab13c"
    tenant_id = "55018a74-e41b-43e5-a3f8-d655685fdbf3"
}

resource "azurerm_resource_group" "demo" {
    name = "demo-rg"
    location = "eastus"
}

resource "random_string" "suffix" {
  length = 4
  lower = true
  upper = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "abhistorage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}