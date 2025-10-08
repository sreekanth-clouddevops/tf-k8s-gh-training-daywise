# create a resource group for the training
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-rg"
  location = var.location
}

# Create VNet & Subnet via module
module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  prefix              = var.resource_prefix
  vnet_cidr           = "10.10.0.0/16"
  subnet_prefix       = "10.10.1.0/24"
}

# Create VM via module (passes the subnet id)
module "vm" {
  source               = "./modules/vm"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  prefix               = var.resource_prefix
  vm_name              = "${var.resource_prefix}-vm"
  vm_size              = "Standard_DS1_v2"
  admin_username       = "azureuser"
  admin_ssh_public_key = var.admin_ssh_public_key
  subnet_id            = module.vnet.subnet_id
  create_public_ip     = true
  os_disk_size_gb      = 30
  data_disk_size_gb    = 0 # set >0 to create an attached data disk
}