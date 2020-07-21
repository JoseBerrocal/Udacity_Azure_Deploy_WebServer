# Resource Group/Location
variable "application_type" {}
variable "resource_type" {}
variable "location" {}
variable "resource_group" {}

# Tags
variable "tags" {
  type = "map"
}