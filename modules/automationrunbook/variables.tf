# Input variable definitions
variable "location" {
  description = "The Azure Region in which all resources groups should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "automation_runbook_name" {
  description = "automation runbook name"
  type        = string
}

variable "automation_account_name" {
  description = "automation account name"
  type        = string
}