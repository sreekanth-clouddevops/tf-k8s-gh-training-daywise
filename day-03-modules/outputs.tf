output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_id" {
  value = module.vnet.subnet_id
}

output "vm_id" {
  value = module.vm.vm_id
}

output "vm_private_ip" {
  value = module.vm.private_ip
}

output "vm_public_ip" {
  value = module.vm.public_ip
}