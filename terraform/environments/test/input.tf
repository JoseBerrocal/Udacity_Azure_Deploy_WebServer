# Azure GUIDS
variable "subscription_id" {default = ""}
variable "client_id" {default = ""}
variable "client_secret" {default = ""}
variable "tenant_id" {default = ""}

# Resource Group/Location
variable "location" {default = ""}
variable "resource_group" {default = ""}
variable "application_type" {default = ""}

# Virtual Network
variable "virtual_network" {default = ""}
variable "address_space" {type = list(string)}

#Virtual SubNet
variable "virtual_subnet" {default = ""}
variable "address_prefix" {default = ""}


# Network Security Group 
variable "network_security_group" {default = ""}
#variable "resource_group_name" {}

# Network Interface
variable "network_interface" {default = ""}
variable "ip_configuration_name" {default = ""}

# Public IP
variable "public_ip_name" {default = ""}

# Load Balancer
variable "load_balancer" {default = ""}
variable "frontend_ip_name" {default = ""}
#variable "network_interface_id" {type    = list(string)}

# Avaliability Set & Virtual Machines
variable "availability_set" {default = ""}
variable "vm_size" {default = ""}
variable "admin_username" {default = ""}
variable "admin_password" {default = ""}
variable "image_id" {default = ""}
variable "tag_name" {default = ""}

variable "instance_count" {
    type = number
    default = 2 
}


# Tags
# Tags
variable tier {}
variable deployment {}