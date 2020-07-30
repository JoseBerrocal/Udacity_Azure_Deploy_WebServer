resource "azurerm_availability_set" "example" {
  name                = var.availability_set
  location            = var.location
  resource_group_name = var.resource_group  
  platform_fault_domain_count  = var.instance_count
  platform_update_domain_count = var.instance_count
  managed                      = true

  tags = {
    environment = var.tag_name
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.instance_count
  name                            = "vm-${count.index}"  
  location            = var.location
  resource_group_name = var.resource_group  
  size                            = var.vm_size 
  admin_username                  = var.admin_username 
  admin_password                  = var.admin_password 
  availability_set_id             = azurerm_availability_set.example.id
  disable_password_authentication = false
  network_interface_ids = [element(var.network_interface_id, count.index)]
  source_image_id                 = var.image_id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

/*
resource "azurerm_managed_disk" "source" {
  count                           = length(var.network_interface_id)
  name                 = "storage-${count.index}"  
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = {
    environment = "staging"
  }
}

*/