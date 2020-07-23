# Resource Group
variable "location" {}
variable "resource_group" {}

# Network Interface
variable "ip_configuration_name" {}

# Load Balancer
variable "load_balancer" {}
variable "frontend_ip_name" {}
variable "public_ip_address_id" {}
variable "network_interface_id" {}