resource "azurerm_network_interface" "example" {
  name                = "${var.network_interface}"
  resource_group_name = "${var.resource_group}" 
  location            = "${var.location}"  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}