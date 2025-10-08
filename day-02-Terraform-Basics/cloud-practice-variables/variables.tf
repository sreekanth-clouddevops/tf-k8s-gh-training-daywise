variable "resource_prefix" {
  description = "Short prefix used in resource names (lowercase, letters/numbers)."
  type        = string
  default     = "abhi"         # change this default or override (see below)
}

variable "rg_name" {
  description = "It is name of RG"
  type = string
  default = "demo-rg"
}
variable "location" {
  description = "Azure location"
  type        = string
  default     = "eastus"
}
variable "storage_account_suffix" {
  description = <<EOT
Short suffix to make the storage account name globally unique.
Must be lowercase letters/numbers only. Example: \"001\" or \"teamx01\".
You can override this per environment (terraform.tfvars or CLI).
EOT
  type    = string
  default = "001"
}
