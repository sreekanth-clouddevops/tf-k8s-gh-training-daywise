locals {
  vnet_name   = length(var.vnet_name) > 0 ? var.vnet_name : "${var.prefix}-vnet"
  subnet_name = length(var.subnet_name) > 0 ? var.subnet_name : "${var.prefix}-subnet"
}

resource "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "this" {
  name                 = local.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_prefix]
}