# Create a PowerShell Automation Runbook
resource "azurerm_automation_runbook" "automation_runbook" {
  name                    = var.automation_runbook_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  log_verbose             = "true"
  log_progress            = "true"
  runbook_type            = "PowerShell"

  content = <<EOT
<#

DESCRIPTION
	This Runbook runs the SQL command in the variable $Query

PARAMETER SqlServer
    String name of the SQL Server to connect to, imported from the variable object in the Automation Account

PARAMETER Database
    String name of the SQL Server database to connect to, imported from the variable object in the Automation Account

PARAMETER SqlCredential
    PSCredential containing a username and password with access to the SQL Server, imported from the credential store in the Automation Account

NOTES
    AUTHOR: Chung
    LASTEDIT: 27-06-2023
#>

#Import your Credential object from the Automation Account
 $SQLServerCred = Get-AutomationPSCredential -Name "SqlCredential"
 #Import the SQL Server Name from the Automation variable.
 $SQL_Server_Name = Get-AutomationVariable -Name "SqlServer"
 #Import the SQL DB from the Automation variable.
 $SQL_DB_Name = Get-AutomationVariable -Name "Database"


# Query to execute
 $Query = "select * from truonghoc"

# Execute query
 "----- Running SQL Command "
 invoke-sqlcmd -ServerInstance "$SQL_Server_Name" -Database "$SQL_DB_Name" -Credential $SQLServerCred -Query "$Query"
 "`n ----- END SQL Command"
EOT
}