# Create Resource Group
resource "azurerm_resource_group" "chung-rg" {
  name     = var.resource_group_name
  location = var.location
}

module "automationaccount" {
  source                  = "./modules/automationaccount" # Mandatory
  automation_account_name = var.automation_account_name
  sku_name                = var.sku_name
  # Resource Group
  location            = azurerm_resource_group.chung-rg.location
  resource_group_name = azurerm_resource_group.chung-rg.name
}

module "automationrunbook" {
  source                  = "./modules/automationrunbook" # Mandatory
  automation_runbook_name = var.automation_runbook_name
  automation_account_name = module.automationaccount.automation_account_name
  # Resource Group
  location            = azurerm_resource_group.chung-rg.location
  resource_group_name = azurerm_resource_group.chung-rg.name
}

module "sqldatabase" {
  source            = "./modules/sqldatabase" # Mandatory
  sql_database_name = var.sql_database_name
  sql_server_name   = module.sqlserver.sql_server_name
  # Resource Group
  location            = azurerm_resource_group.chung-rg.location
  resource_group_name = azurerm_resource_group.chung-rg.name
}

module "sqlserver" {
  source                       = "./modules/sqlserver" # Mandatory
  sql_server_name              = var.sql_server_name
  sql_server_version           = var.sql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = module.keyvaults.sql_admin_password
  firewall_rule_name           = var.firewall_rule_name
  start_ip_address             = var.start_ip_address
  end_ip_address               = var.end_ip_address

  # Resource Group
  location            = azurerm_resource_group.chung-rg.location
  resource_group_name = azurerm_resource_group.chung-rg.name
}

module "keyvaults" {
  source        = "./modules/keyvaults" # Mandatory
  keyvault_name = var.keyvault_name
  secret_name   = var.secret_name
  secret_value  = var.secret_value
  # Resource Group
  location            = azurerm_resource_group.chung-rg.location
  resource_group_name = azurerm_resource_group.chung-rg.name
}

