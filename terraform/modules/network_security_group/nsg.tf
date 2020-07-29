resource "azurerm_network_security_group" "example" {
  name                = var.network_security_group
  location            = var.location
  resource_group_name = var.resource_group
   tags = {
   environment = "Production"
   }
}

resource "azurerm_network_security_rule" "example1" {
  name                        = "secrule1"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
  resource_group_name         = var.resource_group
  network_security_group_name = var.network_security_group
}

resource "azurerm_network_security_rule" "example2" {
  name                        = "secrule2"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
  resource_group_name         = var.resource_group
  network_security_group_name = var.network_security_group
}

resource "azurerm_network_security_rule" "example3" {
  name                        = "secrule3"
  priority                    = 400
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = var.network_security_group
}


resource "azurerm_network_security_rule" "example4" {
  name                        = "secrule4"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
  resource_group_name         = var.resource_group
  network_security_group_name = var.network_security_group
}