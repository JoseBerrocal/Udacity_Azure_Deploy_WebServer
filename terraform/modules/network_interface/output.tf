output "network_interface_id" {
  value = azurerm_network_interface.example[*].id

depends_on = [
  azurerm_network_security_group.example,
 ]

}  