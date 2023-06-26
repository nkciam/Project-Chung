# Create a SQL Database
resource "azurerm_sql_database" "sql_database" {
  name                                 = var.sql_database_name
  location                             = var.location
  resource_group_name                  = var.resource_group_name
  server_name                          = var.sql_server_name
  edition                              = "Standard"
  requested_service_objective_name     = "S0"
  collation                            = "SQL_Latin1_General_CP1_CI_AS"

  tags = {
    environment = "production"
  }
}
