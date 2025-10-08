provider "azurerm" {
    features{}
    subscription_id = "292437ac-a0ee-42bf-9815-3ca12deab13c"
    tenant_id = "55018a74-e41b-43e5-a3f8-d655685fdbf3"
}

resource "azurerm_resource_group" "rg" {
    name = var.rg_name
    location = var.location
}


resource "azurerm_storage_account" "tfstate" {
  name                     = lower("${var.resource_prefix}st${var.storage_account_suffix}")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}