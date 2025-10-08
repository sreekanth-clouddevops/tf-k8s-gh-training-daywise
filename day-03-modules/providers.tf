terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
  required_version = ">= 1.3"
}

provider "azurerm" {
  features {}
  subscription_id = "292437ac-a0ee-42bf-9815-3ca12deab13c"
  tenant_id       = "55018a74-e41b-43e5-a3f8-d655685fdbf3"
}