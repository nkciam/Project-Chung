# Project-ChungNK

---
Title: Create an Automation Account and a SQL Database in Azure and create a Powershell Automation Runbook that can execute an SQL query on the database by Terraform.
---

## Step-01: Introduction
- We will build a Terraform local modules for automationaccount, automationrunbook, sqldatabase, sqlserver, keyvault. 

## Step-02: Create Module Folder Structure
- We are going to create `modules` folder and in that we are going to create a module named `automationaccount`, `automationrunbook`, `sqldatabase`, `sqlserver`, `keyvaults`.
- **Terraform Working Directory:** chnk-umbraco
- modules
- Module-1: automationaccount
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf
- Module-2: automationrunbook
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf
- Module-3: sqldatabase
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf
- Module-4: sqlserver
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf
- Module-5: keyvaults
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf

## Step-03: Root Module: root_versions.tf
- Call Module from Terraform Work Directory
- Create Terraform Configuration in Root Module by calling the newly created module
- versions.tf
- variables.tf
- main.tf
- outputs.tf
```t
# Terraform Block
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate26637"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.0.0"
    }
}
}

# Provider Block
provider "azurerm" {
 features {}          
}
```
## Step-04: root_variables.tf
- Place holder file, if you want you can define variables.

## Step-05: root_main.tf
- Arguments for this module are going to be the variables defined in `root_variables.tf` of local module 
```t
# Call our Custom Terraform Module which we built earlier
module "automationaccount" {
  source                       = "./modules/automationaccount"  # Mandatory
  automation_account_name      = var.automation_account_name
  # Resource Group
  location                     = var.location
  resource_group_name          = var.resource_group_name
}
```

## Step-06: outputs.tf
- The output names defined in local module `outputs.tf` will be the values in this `root_outputs.tf`
```t
# Output variable definitions
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
```
## Step-07: Login to Azure account and Run the script to create new resource group and storage account for store terraform state file before run terraform command. (Run with Bash)
* Login to Azure account:

	az login --tenant "tenant id"

	az account set --subscription "mysubscription"

* Run the script to create reourse group and storage account store terraform state

	sh createstorageaccount.sh

	Go to Azure portal and check resource group "tfstate" and check new storage account name. Replace it to root_versions.tf  --> storage_account_name = "" # Replace name of storage account here

## Step-08: Execute Terraform Commands
```t
# Terraform Initialize
terraform init
Observation: 
1. Verify ".terraform", you will find "modules" folder in addition to "providers" folder
2. Verify inside ".terraform/modules" folder too.

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan --var-file cluster.tfvars

# Terraform Apply
terraform apply --var-file cluster.tfvars -auto-approve

# Verify 
1. Azure Storage Resource Group created (chung-rg and tfstate).
2. Azure Storage Account created (in tfstate resource group).
3. Verify Automation Account, Runbook, SQL Server, SQL Database, KeyVault and KeyVault Secret created.
5. We need to create `SqlCredential` in Credential tab and add `SqlServer`, `Database`in Variables Tab on Automation Account because Runbook will use this information to run the job.
6. Go to SQL Server service and Open Firewall allow MyIP or CompanyIP can access to SQL Server (or we can set it on cluster.tfvars with start_ip_address and end_ip_address variable).
7. Import Module SqlServer Created by: matteot_msft (Go to automation-account-1 --> Modules --> Browse Gallery) and Run the Runbook for testing excute querry.
```


## Step-09: Destroy and Clean-Up
```t
# Terraform Destroy
terraform destroy --var-file cluster.tfvars -auto-approve

# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
```

## Step-10: Understand terraform init command
- We have used `terraform init` to download providers from terraform registry and at the same time to download `modules` present in local modules folder in terraform working directory. 
- Whenever you add a new module to a configuration, Terraform must install the module before it can be used. 
- `terraform init` commands will install and update modules. 
- The `terraform init` command will also initialize backends and install plugins.
```t
# Delete modules in .terraform folder
ls -lrt .terraform/modules
rm -rf .terraform/modules
ls -lrt .terraform/modules

# Terraform Get
terraform get
ls -lrt .terraform/modules
```
## Step10: Major difference between Local and Remote Module
- When installing a remote module, Terraform will download it into the `.terraform` directory in your configuration's root directory. 
- When installing a local module, Terraform will instead refer directly to the source directory. 
- Because of this, Terraform will automatically notice changes to local modules without having to re-run `terraform init`.

Document link:
Azure Automation Account: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_runbook

Azure Runbook: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_runbook

Azure SQL Server: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server.html

Azure SQL Database: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_database

Azre Firewall rule for SQL Server: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_firewall_rule

Azure KeyVault: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
