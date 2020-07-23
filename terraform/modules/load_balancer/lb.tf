resource "azurerm_lb" "example" {
  name                = "${var.load_balancer}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  frontend_ip_configuration {
    name                 = "${var.frontend_ip_name}"
    public_ip_address_id = "${var.public_ip_address_id}"
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = azurerm_lb.example.id
  name                = "acctestpool"
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  network_interface_id    = "${var.network_interface_id}"
  ip_configuration_name   = "${var.ip_configuration_name}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}