resource "azurerm_availability_set" "example" {
  name                = "${var.availability_set}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"  

  tags = {
    environment = "Production"
  }
}