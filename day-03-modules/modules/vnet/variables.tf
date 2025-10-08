variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "prefix" {
  type = string
}
variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_prefix" {
  type    = string
  default = "10.0.1.0/24"
}
variable "vnet_name" {
  type    = string
  default = ""
}
variable "subnet_name" {
  type    = string
  default = ""
}