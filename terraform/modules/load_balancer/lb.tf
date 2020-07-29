resource "azurerm_lb" "example" {
  name                = var.load_balancer
  location            = var.location
  resource_group_name = var.resource_group

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = var.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.example.id
  name                = "acctestpool"
}

resource "azurerm_lb_nat_rule" "example" {
  resource_group_name            = var.resource_group
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "HTTPSAccess"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = azurerm_lb.example.frontend_ip_configuration[0].name
}

resource "azurerm_lb_nat_rule" "example2" {
  resource_group_name            = var.resource_group
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "HTTPAccess"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.example.frontend_ip_configuration[0].name
}

resource "azurerm_lb_nat_rule" "example3" {
  resource_group_name            = var.resource_group
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "SSHAccess"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.example.frontend_ip_configuration[0].name
}


resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count                   = length(var.network_interface_id)
  network_interface_id    = element(var.network_interface_id, count.index)
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}