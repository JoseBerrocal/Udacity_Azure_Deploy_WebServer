# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}

# Virtual Network
variable "virtual_network" {}
variable "address_space" {type    = list(string)}

# Network Security Group 
variable "network_security_group" {}
variable "resource_group_name" {}

# Tags
# Tags
variable tier {}
variable deployment {}