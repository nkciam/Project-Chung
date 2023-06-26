output "sql_server_id" {
  description = "sql server id"
  value       = azurerm_sql_server.sql_server.id
}

output "sql_server_name" {
  description = "sql server name"
  value       = azurerm_sql_server.sql_server.name
}
