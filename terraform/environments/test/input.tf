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


# Tags
# Tags
variable tier {}
variable deployment {}