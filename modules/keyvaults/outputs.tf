output "sql_admin_password" {
  description = "sql admin password"
  value       = azurerm_key_vault_secret.sqladminpassword.value
}