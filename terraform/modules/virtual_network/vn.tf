resource "azurerm_virtual_network" "example" {
  name                = "${var.virtual_network}"
  resource_group_name = "${var.resource_group}" 
  location            = "${var.location}"
  address_space       = "${var.address_space}"
}