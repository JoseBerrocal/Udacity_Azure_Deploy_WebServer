#Resource Group
variable "resource_group" {}
variable "location" {}

#Network Interface
variable "network_interface" {}
variable "subnet_id" {}
variable "ip_configuration_name" {}


variable "instance_count" {type = number}