resource "azurerm_public_ip" "example" {
  name                = "${var.public_ip_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"  
  allocation_method   = "Static"
  
  tags = {
    environment = "Production"
  }
}