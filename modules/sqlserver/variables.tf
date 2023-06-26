# Input variable definitions
variable "location" {
  description = "The Azure Region in which all resources groups should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
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

variable "administrator_login_password" {
  description = "administrator login password"
  type        = string
  sensitive   = true
}

variable "sql_server_version" {
  description = "sql server version"
  type        = string
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
