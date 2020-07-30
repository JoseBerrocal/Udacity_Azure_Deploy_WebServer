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
variable "address_space" {type = list(string)}

#Virtual SubNet
variable "virtual_subnet" {}
variable "address_prefix" {}


# Network Security Group 
variable "network_security_group" {}
#variable "resource_group_name" {}

# Network Interface
variable "network_interface" {}
variable "ip_configuration_name" {}

# Public IP
variable "public_ip_name" {}

# Load Balancer
variable "load_balancer" {}
variable "frontend_ip_name" {}
#variable "network_interface_id" {type    = list(string)}

# Avaliability Set & Virtual Machines
variable "availability_set" {}
variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" {}
variable "image_id" {}
variable "tag_name" {}

variable "instance_count" {type = number}


# Tags
# Tags
variable tier {}
variable deployment {}