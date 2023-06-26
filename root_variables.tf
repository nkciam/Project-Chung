# Input variable definitions
variable "location" {
  description = "The Azure Region in which all resources groups should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "automation_account_name" {
  description = "automation account name"
  type        = string
}

variable "sql_database_name" {
  description = "sql database name"
  type        = string
}

variable "sql_server_name" {
  description = "sql server name"
  type        = string
}

variable "administrator_login" {
  description = "administrator login"
  type        = string
}

variable "automation_runbook_name" {
  description = "automation runbook name"
  type        = string
}

variable "sql_server_version" {
  description = "sql server version"
  type        = string
}

variable "sku_name" {
  description = "sku name"
  type        = string
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
}

variable "secret_name" {
  type        = string
  description = "Key Vault Secret name in Azure"
}

variable "secret_value" {
  type        = string
  description = "Key Vault Secret value in Azure"
  sensitive   = true
}

variable "firewall_rule_name" {
  description = "firewall rule name"
  type        = string
}

variable "start_ip_address" {
  description = "start ip address"
  type        = string
}

variable "end_ip_address" {
  description = "end_ip_address"
  type        = string
}
