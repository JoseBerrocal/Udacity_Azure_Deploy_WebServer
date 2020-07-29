resource "azurerm_subnet" "internal" {
  name                 = var.virtual_subnet
  resource_group_name  = var.resource_group
  #location             = var.location  
  virtual_network_name = var.virtual_network
  address_prefixes       = var.address_prefix
}