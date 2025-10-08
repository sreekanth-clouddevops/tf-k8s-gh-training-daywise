output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "private_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "public_ip" {
  value = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : ""
}