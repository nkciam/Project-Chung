# Input variable definitions
variable "location" {
  description = "The Azure Region in which all resources groups should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
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
