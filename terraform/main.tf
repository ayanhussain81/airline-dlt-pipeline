###############################
# RESOURCE GROUP
###############################

data "azurerm_resource_group" "rg" {
  name = "<Resource-Group>"
}

###############################
# STORAGE ACCOUNT
###############################

resource "azurerm_storage_account" "adls_storage" {

  name                     = "deltalivestorage123"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  account_kind             = "StorageV2"

  is_hns_enabled           = true

  min_tls_version          = "TLS1_2"

  tags = {
    project = "delta-live-tables"
  }
}

###############################
# DATA LAKE FILE SYSTEM
###############################

resource "azurerm_storage_data_lake_gen2_filesystem" "airline_container" {
  name               = "airline-data"
  storage_account_id = azurerm_storage_account.adls_storage.id
}

###############################
# UPLOAD ALL CSV FILES
# FROM LOCAL DATA FOLDER
###############################

resource "azurerm_storage_blob" "csv_uploads" {

  for_each = fileset("${path.module}/Data", "*.csv")

  name                   = "airlines/${each.value}"
  storage_account_name   = azurerm_storage_account.adls_storage.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.airline_container.name

  type   = "Block"
  source = "${path.module}/Data/${each.value}"
}


###############################
# EVENT HUB NAMESPACE
###############################

resource "azurerm_eventhub_namespace" "airline_namespace" {

  name                = "airline-eventhub-namespace"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku      = "Standard"
  capacity = 1
}

###############################
# EVENT HUB
###############################

resource "azurerm_eventhub" "airline_stream" {

  name                = "airline-stream"
  namespace_name      = azurerm_eventhub_namespace.airline_namespace.name
  resource_group_name = data.azurerm_resource_group.rg.name

  partition_count   = 2
  message_retention = 1
}

###############################
# EVENT HUB AUTHORIZATION RULE
###############################

resource "azurerm_eventhub_authorization_rule" "airline_policy" {

  name                = "airline-policy"
  namespace_name      = azurerm_eventhub_namespace.airline_namespace.name
  eventhub_name       = azurerm_eventhub.airline_stream.name
  resource_group_name = data.azurerm_resource_group.rg.name

  listen = true
  send   = true
  manage = true
}

###############################
# DATABRICKS WORKSPACE
###############################

resource "azurerm_databricks_workspace" "databricks_workspace" {

  name                = "delta-live-databricks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  sku = "premium"

  managed_resource_group_name = "delta-live-managed-rg"

  tags = {
    environment = "dev"
  }
}