resource "azurerm_network_interface" "example" {
  count               = var.instance_count
  name                = "${var.network_interface}-nic-${count.index}"
  resource_group_name = var.resource_group 
  location            = var.location  

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}