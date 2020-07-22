#Resource Group
variable "resource_group" {}
variable "location" {}

# Virtual Network
variable "virtual_network" {}
variable "address_space" {type    = list(string)}