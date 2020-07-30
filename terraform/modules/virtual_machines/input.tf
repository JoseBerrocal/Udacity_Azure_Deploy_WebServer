# Resource Group
variable "resource_group" {}
variable "location" {}

# Network Interface
variable "network_interface_id" {type = list(string)}

# Availability Set & Virtual Machines
variable "availability_set" {}
variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" {}
variable "image_id" {}

variable "instance_count" {}