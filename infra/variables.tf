# Azure Workspace Resource ID
variable "azure_workspace_resource_id" {
  description = "The resource ID of the Azure Databricks workspace"
  type        = string
}

# User's Full Name
variable "nome_completo" {
  description = "The full name of the user for catalog naming"
  type        = string
}

# Databricks Token
variable "databricks_token" {
  description = "The personal access token for Databricks authentication"
  type        = string
  sensitive   = true
}
