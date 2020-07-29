# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
**Your words here**

1. Clone the repository
2. [Configure the storage account and stated backend](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage). Replace the values below in */terraform/environments/test/main.tf* with the output from the Azure CLI:
- storage_account_name
- container_name
- access_key

3. [Create a Service Principal for Terraform](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html). Replace the values below in */terraform/environments/test/terraform.tfvars* and in *server.json* with the output from the Azure CLI:
- subscription_id
- client_id
- client_secret
- tenant_id

4. Create a Service group and put the name in "managed_image_resource_group_name"
This repository will be use first to create an ubuntu image usign  packer

```bash
az group create -l westus2 -n MyResourceGroup
```
5. Make sure the location of the new resource group is the same as the one the image will be created, the same make sure the location is updated in *location*

5. Create the ubuntu image
```bash
packer build server.json
```

6. Deploy the  terraform infraestructure
```bash
cd terraform/environments/test/
terraform init
terraform plan -out solution.plan
terraform apply solution.plan 
```

### Output
**Your words here**


The output from creating the ubuntu is the following:

```bash
server.jsonazure-arm: output will be in this color.

==> azure-arm: Running builder ...
==> azure-arm: Getting tokens using client secret
==> azure-arm: Getting tokens using client secret
    azure-arm: Creating Azure Resource Manager (ARM) client ...
==> azure-arm: WARNING: Zone resiliency may not be supported in West US, checkout the docs at https://docs.microsoft.com/en-us/azure/availability-zones/
==> azure-arm: Creating resource group ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> Location          : 'West US'
==> azure-arm:  -> Tags              :
==> azure-arm:  ->> name : deploy-im
==> azure-arm:  ->> environment : production
==> azure-arm:  ->> dept : Engineering
==> azure-arm:  ->> task : Image deployment
==> azure-arm:  ->> created_by : packer
==> azure-arm: Validating deployment template ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> DeploymentName    : 'pkrdpsxdmx8mtdl'
==> azure-arm: Deploying deployment template ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> DeploymentName    : 'pkrdpsxdmx8mtdl'
==> azure-arm: Getting the VM's IP address ...
==> azure-arm:  -> ResourceGroupName   : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> PublicIPAddressName : 'pkripsxdmx8mtdl'
==> azure-arm:  -> NicName             : 'pkrnisxdmx8mtdl'
==> azure-arm:  -> Network Connection  : 'PublicEndpoint'
==> azure-arm:  -> IP Address          : '40.78.124.176'
==> azure-arm: Waiting for SSH to become available...
==> azure-arm: Connected to SSH!
==> azure-arm: Provisioning with shell script: /tmp/packer-shell825984892
==> azure-arm: + echo Hello, World!
==> azure-arm: Querying the machine's properties ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> ComputeName       : 'pkrvmsxdmx8mtdl'
==> azure-arm:  -> Managed OS Disk   : '/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/PKR-RESOURCE-GROUP-SXDMX8MTDL/providers/Microsoft.Compute/disks/pkrossxdmx8mtdl'
==> azure-arm: Querying the machine's additional disks properties ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> ComputeName       : 'pkrvmsxdmx8mtdl'
==> azure-arm: Powering off machine ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> ComputeName       : 'pkrvmsxdmx8mtdl'
==> azure-arm: Capturing image ...
==> azure-arm:  -> Compute ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm:  -> Compute Name              : 'pkrvmsxdmx8mtdl'
==> azure-arm:  -> Compute Location          : 'West US'
==> azure-arm:  -> Image ResourceGroupName   : 'sg_image_webserver_azure'
==> azure-arm:  -> Image Name                : 'ubuntuImage'
==> azure-arm:  -> Image Location            : 'West US'
==> azure-arm: Deleting resource group ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-sxdmx8mtdl'
==> azure-arm: 
==> azure-arm: The resource group was created by Packer, deleting ...
==> azure-arm: Deleting the temporary OS disk ...
==> azure-arm:  -> OS Disk : skipping, managed disk was used...
==> azure-arm: Deleting the temporary Additional disk ...
==> azure-arm:  -> Additional Disk : skipping, managed disk was used...
==> azure-arm: Removing the created Deployment object: 'pkrdpsxdmx8mtdl'
==> azure-arm: ERROR: -> ResourceGroupNotFound : Resource group 'pkr-Resource-Group-sxdmx8mtdl' could not be found.
==> azure-arm:
Build 'azure-arm' finished.

==> Builds finished. The artifacts of successful builds are:
--> azure-arm: Azure.ResourceManagement.VMImage:

OSType: Linux
ManagedImageResourceGroupName: sg_image_webserver_azure
ManagedImageName: ubuntuImage
ManagedImageId: /subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage
ManagedImageLocation: West US
```

The output from creating the infraestructure using terraform is the following:

```bash
(.deploy-webserver) [casita@localhost test]$ terraform plan -out solution.plan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.availability_set_virtual_machines.azurerm_availability_set.example will be created
  + resource "azurerm_availability_set" "example" {
      + id                           = (known after apply)
      + location                     = "westus2"
      + managed                      = true
      + name                         = "AvailabilitySet"
      + platform_fault_domain_count  = 2
      + platform_update_domain_count = 2
      + resource_group_name          = "deploy_webpage_rg"
      + tags                         = {
          + "environment" = "Production"
        }
    }

  # module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[0] will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_password                  = (sensitive value)
      + admin_username                  = "casita"
      + allow_extension_operations      = true
      + availability_set_id             = (known after apply)
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + id                              = (known after apply)
      + location                        = "westus2"
      + max_bid_price                   = -1
      + name                            = "vm-0"
      + network_interface_ids           = (known after apply)
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "deploy_webpage_rg"
      + size                            = "Standard_F2"
      + source_image_id                 = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage"
      + virtual_machine_id              = (known after apply)
      + zone                            = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }
    }

  # module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[1] will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_password                  = (sensitive value)
      + admin_username                  = "casita"
      + allow_extension_operations      = true
      + availability_set_id             = (known after apply)
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + id                              = (known after apply)
      + location                        = "westus2"
      + max_bid_price                   = -1
      + name                            = "vm-1"
      + network_interface_ids           = (known after apply)
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "deploy_webpage_rg"
      + size                            = "Standard_F2"
      + source_image_id                 = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage"
      + virtual_machine_id              = (known after apply)
      + zone                            = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }
    }

  # module.load_balancer.azurerm_lb.example will be created
  + resource "azurerm_lb" "example" {
      + id                   = (known after apply)
      + location             = "westus2"
      + name                 = "WebPage-LoadBalancer"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "deploy_webpage_rg"
      + sku                  = "Basic"

      + frontend_ip_configuration {
          + id                            = (known after apply)
          + inbound_nat_rules             = (known after apply)
          + load_balancer_rules           = (known after apply)
          + name                          = "FrontEnd-PublicIPAdress"
          + outbound_rules                = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = (known after apply)
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + public_ip_prefix_id           = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # module.load_balancer.azurerm_lb_backend_address_pool.example will be created
  + resource "azurerm_lb_backend_address_pool" "example" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "acctestpool"
      + resource_group_name       = "deploy_webpage_rg"
    }

  # module.load_balancer.azurerm_lb_nat_rule.example will be created
  + resource "azurerm_lb_nat_rule" "example" {
      + backend_ip_configuration_id    = (known after apply)
      + backend_port                   = 443
      + enable_floating_ip             = (known after apply)
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
      + frontend_port                  = 443
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = (known after apply)
      + loadbalancer_id                = (known after apply)
      + name                           = "HTTPSAccess"
      + protocol                       = "tcp"
      + resource_group_name            = "deploy_webpage_rg"
    }

  # module.load_balancer.azurerm_lb_nat_rule.example2 will be created
  + resource "azurerm_lb_nat_rule" "example2" {
      + backend_ip_configuration_id    = (known after apply)
      + backend_port                   = 80
      + enable_floating_ip             = (known after apply)
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
      + frontend_port                  = 80
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = (known after apply)
      + loadbalancer_id                = (known after apply)
      + name                           = "HTTPAccess"
      + protocol                       = "tcp"
      + resource_group_name            = "deploy_webpage_rg"
    }

  # module.load_balancer.azurerm_lb_nat_rule.example3 will be created
  + resource "azurerm_lb_nat_rule" "example3" {
      + backend_ip_configuration_id    = (known after apply)
      + backend_port                   = 22
      + enable_floating_ip             = (known after apply)
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
      + frontend_port                  = 22
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = (known after apply)
      + loadbalancer_id                = (known after apply)
      + name                           = "SSHAccess"
      + protocol                       = "tcp"
      + resource_group_name            = "deploy_webpage_rg"
    }

  # module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[0] will be created
  + resource "azurerm_network_interface_backend_address_pool_association" "example" {
      + backend_address_pool_id = (known after apply)
      + id                      = (known after apply)
      + ip_configuration_name   = "internal"
      + network_interface_id    = (known after apply)
    }

  # module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[1] will be created
  + resource "azurerm_network_interface_backend_address_pool_association" "example" {
      + backend_address_pool_id = (known after apply)
      + id                      = (known after apply)
      + ip_configuration_name   = "internal"
      + network_interface_id    = (known after apply)
    }

  # module.network_interface.azurerm_network_interface.example[0] will be created
  + resource "azurerm_network_interface" "example" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "westus2"
      + mac_address                   = (known after apply)
      + name                          = "network_interface-nic-0"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "deploy_webpage_rg"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "internal"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # module.network_interface.azurerm_network_interface.example[1] will be created
  + resource "azurerm_network_interface" "example" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "westus2"
      + mac_address                   = (known after apply)
      + name                          = "network_interface-nic-1"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "deploy_webpage_rg"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "internal"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # module.network_security_group.azurerm_network_security_group.example will be created
  + resource "azurerm_network_security_group" "example" {
      + id                  = (known after apply)
      + location            = "westus2"
      + name                = "network_secgroup_webpage"
      + resource_group_name = "deploy_webpage_rg"
      + security_rule       = (known after apply)
      + tags                = {
          + "environment" = "Production"
        }
    }

  # module.network_security_group.azurerm_network_security_rule.example1 will be created
  + resource "azurerm_network_security_rule" "example1" {
      + access                      = "Allow"
      + destination_address_prefix  = "10.0.0.0/16"
      + destination_port_range      = "22"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "secrule1"
      + network_security_group_name = "network_secgroup_webpage"
      + priority                    = 200
      + protocol                    = "Tcp"
      + resource_group_name         = "deploy_webpage_rg"
      + source_address_prefix       = "10.0.0.0/16"
      + source_port_range           = "22"
    }

  # module.network_security_group.azurerm_network_security_rule.example2 will be created
  + resource "azurerm_network_security_rule" "example2" {
      + access                      = "Allow"
      + destination_address_prefix  = "10.0.0.0/16"
      + destination_port_range      = "80"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "secrule2"
      + network_security_group_name = "network_secgroup_webpage"
      + priority                    = 300
      + protocol                    = "Tcp"
      + resource_group_name         = "deploy_webpage_rg"
      + source_address_prefix       = "10.0.0.0/16"
      + source_port_range           = "80"
    }

  # module.network_security_group.azurerm_network_security_rule.example3 will be created
  + resource "azurerm_network_security_rule" "example3" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "secrule3"
      + network_security_group_name = "network_secgroup_webpage"
      + priority                    = 400
      + protocol                    = "Tcp"
      + resource_group_name         = "deploy_webpage_rg"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.network_security_group.azurerm_network_security_rule.example4 will be created
  + resource "azurerm_network_security_rule" "example4" {
      + access                      = "Allow"
      + destination_address_prefix  = "10.0.0.0/16"
      + destination_port_range      = "443"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "secrule4"
      + network_security_group_name = "network_secgroup_webpage"
      + priority                    = 500
      + protocol                    = "Tcp"
      + resource_group_name         = "deploy_webpage_rg"
      + source_address_prefix       = "10.0.0.0/16"
      + source_port_range           = "*"
    }

  # module.public_ip.azurerm_public_ip.example will be created
  + resource "azurerm_public_ip" "example" {
      + allocation_method       = "Static"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "westus2"
      + name                    = "publicIP"
      + resource_group_name     = "deploy_webpage_rg"
      + sku                     = "Basic"
      + tags                    = {
          + "environment" = "Production"
        }
    }

  # module.resource_group.azurerm_resource_group.test will be created
  + resource "azurerm_resource_group" "test" {
      + id       = (known after apply)
      + location = "westus2"
      + name     = "deploy_webpage_rg"
    }

  # module.virtual_network.azurerm_virtual_network.example will be created
  + resource "azurerm_virtual_network" "example" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "westus2"
      + name                = "vir_net_webapp"
      + resource_group_name = "deploy_webpage_rg"
      + subnet              = (known after apply)
    }

  # module.virtual_subnet.azurerm_subnet.internal will be created
  + resource "azurerm_subnet" "internal" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "internal_virtsubnet"
      + resource_group_name                            = "deploy_webpage_rg"
      + virtual_network_name                           = "vir_net_webapp"
    }

Plan: 21 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: solution.plan

To perform exactly these actions, run the following command to apply:
    terraform apply "solution.plan"

Releasing state lock. This may take a few moments...
(.deploy-webserver) [casita@localhost test]$ 
```