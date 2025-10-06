variable "project_name" { type = string }
variable "location"     { type = string  default = "eastus" }

# Resource Group
variable "rg_name" { type = string }

# Existing networking (reuse your current VNet)
variable "vnet_rg"        { type = string }
variable "vnet_name"      { type = string }
variable "subnet_apps"    { type = string }  # subnet name for VNet Integration

# SQL connectivity (assumes you already have SQL Private Endpoint + Private DNS)
# App will use VNet Integration to reach SQL via Private DNS name.
variable "sql_hostname"   { type = string  description = "FQDN of SQL server (privatelink)" }
variable "sql_db_name"    { type = string }
variable "sql_user"       { type = string }
variable "sql_password"   { type = string  sensitive = true }

# App Gateway public IP for Access Restrictions (Option A)
variable "appgw_public_ip" { type = string  description = "IPv4 of App Gateway public frontend" }

# Names for App Service resources
variable "appservice_plan_sku" { type = string  default = "P1v3" }
variable "frontend_app_name"   { type = string }
variable "backend_app_name"    { type = string }

# Application Insights (optional)
variable "appinsights_location"       { type = string  default = "eastus" }
variable "appinsights_name"           { type = string  default = null }
variable "instrumentation_key"        { type = string  default = null }
variable "connection_string_appi"     { type = string  default = null }

# Java runtime stack for backend (Linux)
variable "java_major_version" { type = number default = 17 }
