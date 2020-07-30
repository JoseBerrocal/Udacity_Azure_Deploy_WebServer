provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tstate26625"
    container_name       = "tstate"
    key                  = "5iZBzgRsP4DICmOq+xI7LheJHVaskwb9qcqK5ZfvIlILE56nHkKCNV8X/GQrpzGbKWm1H/WKt6XmbmXaf0X64A=="
    access_key           = "5iZBzgRsP4DICmOq+xI7LheJHVaskwb9qcqK5ZfvIlILE56nHkKCNV8X/GQrpzGbKWm1H/WKt6XmbmXaf0X64A=="
  }
}

locals {
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }

}

module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
}

# Create a virtual network
module "virtual_network" {
  source              = "../../modules/virtual_network"  
  virtual_network     = var.virtual_network
  resource_group      = module.resource_group.resource_group_name
  location            = var.location
  address_space       = var.address_space
}



# Create a virtual subnet
module "virtual_subnet" {
  source              = "../../modules/virtual_subnet"  
  virtual_subnet      = var.virtual_subnet
  resource_group      = module.resource_group.resource_group_name
  location            = var.location
  virtual_network     = module.virtual_network.virtual_network_name
  address_prefix      = var.address_prefix
}

# Create the Network Security Group
module "network_security_group" {
  source                  = "../../modules/network_security_group"
  network_security_group  = var.network_security_group
  location                = var.location
  resource_group          = module.resource_group.resource_group_name
}

# Create the Network Interface
module "network_interface" {
  source                  = "../../modules/network_interface"  
  instance_count          = var.instance_count
  network_interface       = var.network_interface
  location                = var.location
  resource_group          = module.resource_group.resource_group_name
  subnet_id               = module.virtual_subnet.virtual_subnet_id
  ip_configuration_name   = var.ip_configuration_name
}

# Create Public IP
module "public_ip" {
  source              = "../../modules/public_ip" 
  public_ip_name      = var.public_ip_name
  location            = var.location
  resource_group      = module.resource_group.resource_group_name
}

# Create a Load Balancer 
module "load_balancer" {
  source                  = "../../modules/load_balancer"   
  instance_count                   = var.instance_count
  load_balancer           = var.load_balancer
  location                = var.location
  resource_group          = module.resource_group.resource_group_name
  frontend_ip_name        = var.frontend_ip_name
  public_ip_address_id    = module.public_ip.public_ip_id
  network_interface_id    = module.network_interface.network_interface_id
  ip_configuration_name   = var.ip_configuration_name  
}

# Availability Set and Virtual Machines
module "availability_set_virtual_machines" {
  source                  = "../../modules/virtual_machines" 
  instance_count                   = var.instance_count
  availability_set        = var.availability_set
  location                = var.location
  resource_group          = module.resource_group.resource_group_name
  vm_size                 = var.vm_size
  admin_username          = var.admin_username
  admin_password          = var.admin_password
  network_interface_id    = module.network_interface.network_interface_id
  image_id                = var.image_id
  tag_name                = var.tag_name
}



# Reference the AppService Module here.

/*module "app_service" {
  source               = "../../modules/appservice"
  location             = "${var.location}"
  application_type     = "${var.application_type}"
  resource_type        = "AppService"
  resource_group       = "${module.resource_group.resource_group_name}"
  tags                 = "${local.tags}"
}*/
