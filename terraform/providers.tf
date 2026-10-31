terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.52.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id       = ""
}

provider "databricks" {
  alias = "workspace"
  azure_workspace_resource_id = azurerm_databricks_workspace.databricks.id
}
