# Create a SQL Server
resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = var.sql_server_version  
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  tags = {
    environment = "production"
  }
}

resource "azurerm_sql_firewall_rule" "firewall_rule" {
  name                = var.firewall_rule_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address 
}

