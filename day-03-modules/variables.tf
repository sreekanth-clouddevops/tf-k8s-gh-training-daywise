variable "resource_prefix" {
  type        = string
  default     = "demo"
  description = "prefix for resource names"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "Public SSH key for VM access (ssh-rsa ...). Provide via terraform.tfvars or TF_VAR_..."
  default     = ""
}