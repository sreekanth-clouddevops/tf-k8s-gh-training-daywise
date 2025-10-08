variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "prefix" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}
variable "admin_username" {
  type    = string
  default = "azureuser"
}
variable "admin_ssh_public_key" {
  type    = string
  default = ""
} # required for SSH access
variable "subnet_id" {
  type = string
}
variable "create_public_ip" {
  type    = bool
  default = true
}
variable "os_disk_size_gb" {
  type    = number
  default = 30
}
variable "data_disk_size_gb" {
  type    = number
  default = 0
}