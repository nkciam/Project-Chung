output "automation_account_id" {
  description = "automation account id"
  value       = azurerm_automation_account.automation_account.id
}

output "automation_account_name" {
  description = "automation account name"
  value       = azurerm_automation_account.automation_account.name
}