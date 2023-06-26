output "root_automation_account_id" {
  description = "The name of the resource group"
  value       = module.automationaccount.automation_account_id
}

output "root_automation_runbook_id" {
  description = "automation runbook id"
  value       = module.automationrunbook.automation_runbook_id
}

output "root_sql_database_id" {
  description = "sql database id"
  value       = module.sqldatabase.sql_database_id
}

output "root_sql_server_id" {
  description = "sql server id"
  value       = module.sqlserver.sql_server_id
}

