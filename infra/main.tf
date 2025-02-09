# Terraform configuration
terraform {
  required_version = ">=1.2.9"
  required_providers {
    azurerm   = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    databricks = {
      source   = "databricks/databricks"
      version  = "~> 1.64.1"
    }
  }
  
}

# Azure provider configuration
provider "azurerm" {
  features {}
}

# Databricks provider configuration
provider "databricks" {
  host  = "https://adb-1770141292543280.0.azuredatabricks.net"
  token = var.databricks_token
}

resource "databricks_catalog" "raw" {
  name       = "${var.nome_completo}_raw"
  comment    = "this catalog is managed by terraform" 
}
resource "databricks_catalog" "stg" {
  name       = "${var.nome_completo}_stg"
  comment    = "this catalog is managed by terraform" 
}

resource "databricks_schema" "raw" {
  depends_on = [databricks_catalog.raw]
  catalog_name = databricks_catalog.raw.id  
  name         = "schema"
  comment      = "this database is managed by terraform"
}

resource "databricks_schema" "stg" {
  depends_on = [databricks_catalog.stg]
  catalog_name = databricks_catalog.stg.id
  name         = "schema"
  comment      = "this database is managed by terraform"
}

