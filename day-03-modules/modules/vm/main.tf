############################################################
# modules/vm/main.tf
# Creates optional public IP, NIC, Linux VM,
# optional managed data disk + attachment (created/attached only if size > 0).
############################################################

# Optional Public IP (created only when var.create_public_ip == true)
resource "azurerm_public_ip" "this" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# Network Interface associated to subnet; attach the public IP if present
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = length(azurerm_public_ip.this) > 0 ? azurerm_public_ip.this[0].id : null
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_username        = var.admin_username

  # SSH public key (if empty, VM will still be created but SSH access won't work)
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_public_key != "" ? [var.admin_ssh_public_key] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_public_key
    }
    
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    Name = var.vm_name
  }
}

# --- managed data disk (create only if var.data_disk_size_gb > 0) ---
resource "azurerm_managed_disk" "data_disk" {
  count                = var.data_disk_size_gb > 0 ? 1 : 0
  name                 = "${var.vm_name}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb

  tags = {
    Name = "${var.vm_name}-data"
  }
}

# Attach the managed disk to the VM (only when created)
resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  count              = var.data_disk_size_gb > 0 ? 1 : 0
  managed_disk_id    = azurerm_managed_disk.data_disk[0].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = 0
  caching            = "ReadOnly"
}