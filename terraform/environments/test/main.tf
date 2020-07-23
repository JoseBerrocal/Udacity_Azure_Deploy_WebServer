provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tstate32610"
    container_name       = "tstate"
    key                  = "vXUTpKk4zaTrGhirLY8oKym3tASyz8xw7i7W4U4uKyZQk9RsiLyf88xNB7dbUhenS86MRWahXxdpSBeUSwycKw=="
    access_key           = "vXUTpKk4zaTrGhirLY8oKym3tASyz8xw7i7W4U4uKyZQk9RsiLyf88xNB7dbUhenS86MRWahXxdpSBeUSwycKw=="
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
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}


# Create a virtual network
module "virtual_network" {
  source              = "../../modules/virtual_network"  
  virtual_network     = "${var.virtual_network}"
  resource_group      = "${module.resource_group.resource_group_name}"
  location            = "${var.location}"
  address_space       = "${var.address_space}"
}

# Create a virtual subnet
module "virtual_subnet" {
  source              = "../../modules/virtual_subnet"  
  virtual_subnet      = "${var.virtual_subnet}"   
  resource_group      = "${module.resource_group.resource_group_name}"
  location            = "${var.location}"
  virtual_network     = "${module.virtual_network.virtual_network_name}"
  address_prefix      = "${var.address_prefix}"
}

# Create the Network Security Group
module "network_security_group" {
  source                  = "../../modules/network_security_group"
  network_security_group  = "${var.network_security_group}"
  location                = "${var.location}"
  resource_group          = "${module.resource_group.resource_group_name}"
}

# Create the Network Interface
module "network_interface" {
  source                  = "../../modules/network_interface"  
  network_interface       = "${var.network_interface}"
  location                = "${var.location}"
  resource_group          = "${module.resource_group.resource_group_name}"
  subnet_id               = "${module.virtual_subnet.virtual_subnet_id}"  
}

# Create Public IP
module "public_ip" {
  source              = "../../modules/public_ip" 
  public_ip_name      = "${var.public_ip_name}"
  location            = "${var.location}"
  resource_group      = "${module.resource_group.resource_group_name}"
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
