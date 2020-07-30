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

1. Clone the repository
```bash
git clone https://github.com/JoseBerrocal/Udacity_Azure_Deploy_WebServer.git
```
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

6. Create the ubuntu image
```bash
packer build server.json
```

7. Use the output *ManagedImageId* from the command *packer build server.json*, update "image_id" in *terraform/environments/test/terraform.tfvars*


8. Update the values you require for your deployment in *terraform/environments/test/terraform.tfvars*, like:

```bash
# Resource Group/Location
location = "West US 2"
resource_group = "deploy_webpage_rg"

# Virtual Network
virtual_network = "vir_net_webapp"
address_space = ["10.0.0.0/16"]

# Virtual SubNetwork
virtual_subnet = "internal_virtsubnet"
address_prefix = ["10.0.1.0/24"]

# Network Security Group
network_security_group = "network_secgroup_webpage"

# Network Interface
network_interface = "network_interface"
ip_configuration_name = "internal"

# Public IP
public_ip_name = "publicIP"

# Load Balancer
load_balancer = "WebPage-LoadBalancer"
frontend_ip_name = "FrontEnd-PublicIPAdress"

# Availability Set &  Virtual Machines
availability_set = "AvailabilitySet"
vm_size = "Standard_F2"
admin_username = "casita"
admin_password = "P@ssw0rd1234!"
instance_count = 2
image_id = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage"

#resource_type = "AppService"
application_type = "AzureJBmyApplication1" # This name has to be globally unique.
```


9. Deploy the  terraform infraestructure
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
(.deploy-webserver) [casita@localhost test]$ terraform show 

# module.availability_set_virtual_machines.azurerm_availability_set.example:
resource "azurerm_availability_set" "example" {
    id                           = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/availabilitySets/AvailabilitySet"
    location                     = "westus2"
    managed                      = true
    name                         = "AvailabilitySet"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 2
    resource_group_name          = "deploy_webpage_rg"
    tags                         = {
        "environment" = "Production"
    }
}

# module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[1]:
resource "azurerm_linux_virtual_machine" "main" {
    admin_password                  = (sensitive value)
    admin_username                  = "casita"
    allow_extension_operations      = true
    availability_set_id             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/availabilitySets/AVAILABILITYSET"
    computer_name                   = "vm-1"
    disable_password_authentication = false
    id                              = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-1"
    location                        = "westus2"
    max_bid_price                   = -1
    name                            = "vm-1"
    network_interface_ids           = [
        "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1",
    ]
    priority                        = "Regular"
    private_ip_address              = "10.0.1.5"
    private_ip_addresses            = [
        "10.0.1.5",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "deploy_webpage_rg"
    size                            = "Standard_F2"
    source_image_id                 = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage"
    tags                            = {}
    virtual_machine_id              = "766c850c-a54f-414b-a86e-da852184787c"

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "vm-1_disk1_01973dd083b04382a76741aa98750184"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}

# module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[0]:
resource "azurerm_linux_virtual_machine" "main" {
    admin_password                  = (sensitive value)
    admin_username                  = "casita"
    allow_extension_operations      = true
    availability_set_id             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/availabilitySets/AVAILABILITYSET"
    computer_name                   = "vm-0"
    disable_password_authentication = false
    id                              = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-0"
    location                        = "westus2"
    max_bid_price                   = -1
    name                            = "vm-0"
    network_interface_ids           = [
        "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0",
    ]
    priority                        = "Regular"
    private_ip_address              = "10.0.1.4"
    private_ip_addresses            = [
        "10.0.1.4",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "deploy_webpage_rg"
    size                            = "Standard_F2"
    source_image_id                 = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/sg_image_webserver_azure/providers/Microsoft.Compute/images/ubuntuImage"
    tags                            = {}
    virtual_machine_id              = "e2927194-80e7-4244-867a-7f5a30a4d298"

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "vm-0_disk1_e24e37f3956e4896849c6aeb1a86ce12"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}


# module.public_ip.azurerm_public_ip.example:
resource "azurerm_public_ip" "example" {
    allocation_method       = "Static"
    id                      = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/publicIPAddresses/publicIP"
    idle_timeout_in_minutes = 4
    ip_address              = "52.233.67.112"
    ip_version              = "IPv4"
    location                = "westus2"
    name                    = "publicIP"
    resource_group_name     = "deploy_webpage_rg"
    sku                     = "Basic"
    tags                    = {
        "environment" = "Production"
    }
    zones                   = []
}


# module.virtual_network.azurerm_virtual_network.example:
resource "azurerm_virtual_network" "example" {
    address_space       = [
        "10.0.0.0/16",
    ]
    dns_servers         = []
    guid                = "b144b5dd-0961-44de-980c-a9f8c4ca8f53"
    id                  = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp"
    location            = "westus2"
    name                = "vir_net_webapp"
    resource_group_name = "deploy_webpage_rg"
    subnet              = [
        {
            address_prefix = "10.0.1.0/24"
            id             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp/subnets/internal_virtsubnet"
            name           = "internal_virtsubnet"
            security_group = ""
        },
    ]
    tags                = {}
}


# module.load_balancer.azurerm_lb.example:
resource "azurerm_lb" "example" {
    id                   = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer"
    location             = "westus2"
    name                 = "WebPage-LoadBalancer"
    private_ip_addresses = []
    resource_group_name  = "deploy_webpage_rg"
    sku                  = "Basic"
    tags                 = {}

    frontend_ip_configuration {
        id                            = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/frontendIPConfigurations/FrontEnd-PublicIPAdress"
        inbound_nat_rules             = [
            "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPAccess",
            "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPSAccess",
            "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/SSHAccess",
        ]
        load_balancer_rules           = []
        name                          = "FrontEnd-PublicIPAdress"
        outbound_rules                = []
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        public_ip_address_id          = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/publicIPAddresses/publicIP"
        zones                         = []
    }
}

# module.load_balancer.azurerm_lb_backend_address_pool.example:
resource "azurerm_lb_backend_address_pool" "example" {
    backend_ip_configurations = [
        "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0/ipConfigurations/internal",
        "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1/ipConfigurations/internal",
    ]
    id                        = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool"
    load_balancing_rules      = []
    loadbalancer_id           = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer"
    name                      = "acctestpool"
    resource_group_name       = "deploy_webpage_rg"
}

# module.load_balancer.azurerm_lb_nat_rule.example:
resource "azurerm_lb_nat_rule" "example" {
    backend_port                   = 443
    enable_floating_ip             = false
    enable_tcp_reset               = false
    frontend_ip_configuration_id   = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/frontendIPConfigurations/FrontEnd-PublicIPAdress"
    frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
    frontend_port                  = 443
    id                             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPSAccess"
    idle_timeout_in_minutes        = 4
    loadbalancer_id                = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer"
    name                           = "HTTPSAccess"
    protocol                       = "Tcp"
    resource_group_name            = "deploy_webpage_rg"
}

# module.load_balancer.azurerm_lb_nat_rule.example2:
resource "azurerm_lb_nat_rule" "example2" {
    backend_port                   = 80
    enable_floating_ip             = false
    enable_tcp_reset               = false
    frontend_ip_configuration_id   = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/frontendIPConfigurations/FrontEnd-PublicIPAdress"
    frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
    frontend_port                  = 80
    id                             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPAccess"
    idle_timeout_in_minutes        = 4
    loadbalancer_id                = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer"
    name                           = "HTTPAccess"
    protocol                       = "Tcp"
    resource_group_name            = "deploy_webpage_rg"
}

# module.load_balancer.azurerm_lb_nat_rule.example3:
resource "azurerm_lb_nat_rule" "example3" {
    backend_port                   = 22
    enable_floating_ip             = false
    enable_tcp_reset               = false
    frontend_ip_configuration_id   = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/frontendIPConfigurations/FrontEnd-PublicIPAdress"
    frontend_ip_configuration_name = "FrontEnd-PublicIPAdress"
    frontend_port                  = 22
    id                             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/SSHAccess"
    idle_timeout_in_minutes        = 4
    loadbalancer_id                = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer"
    name                           = "SSHAccess"
    protocol                       = "Tcp"
    resource_group_name            = "deploy_webpage_rg"
}

# module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[0]:
resource "azurerm_network_interface_backend_address_pool_association" "example" {
    backend_address_pool_id = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool"
    id                      = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0/ipConfigurations/internal|/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool"
    ip_configuration_name   = "internal"
    network_interface_id    = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0"
}

# module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[1]:
resource "azurerm_network_interface_backend_address_pool_association" "example" {
    backend_address_pool_id = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool"
    id                      = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1/ipConfigurations/internal|/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool"
    ip_configuration_name   = "internal"
    network_interface_id    = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1"
}


# module.network_interface.azurerm_network_interface.example[1]:
resource "azurerm_network_interface" "example" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1"
    internal_domain_name_suffix   = "1w0ujmlbbhpejgamvh2mjsupkd.xx.internal.cloudapp.net"
    location                      = "westus2"
    mac_address                   = "00-0D-3A-FC-04-63"
    name                          = "network_interface-nic-1"
    private_ip_address            = "10.0.1.5"
    private_ip_addresses          = [
        "10.0.1.5",
    ]
    resource_group_name           = "deploy_webpage_rg"
    tags                          = {}
    virtual_machine_id            = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-1"

    ip_configuration {
        name                          = "internal"
        primary                       = true
        private_ip_address            = "10.0.1.5"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp/subnets/internal_virtsubnet"
    }
}

# module.network_interface.azurerm_network_interface.example[0]:
resource "azurerm_network_interface" "example" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0"
    internal_domain_name_suffix   = "1w0ujmlbbhpejgamvh2mjsupkd.xx.internal.cloudapp.net"
    location                      = "westus2"
    mac_address                   = "00-0D-3A-C3-1D-9C"
    name                          = "network_interface-nic-0"
    private_ip_address            = "10.0.1.4"
    private_ip_addresses          = [
        "10.0.1.4",
    ]
    resource_group_name           = "deploy_webpage_rg"
    tags                          = {}
    virtual_machine_id            = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-0"

    ip_configuration {
        name                          = "internal"
        primary                       = true
        private_ip_address            = "10.0.1.4"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp/subnets/internal_virtsubnet"
    }
}


# module.virtual_subnet.azurerm_subnet.internal:
resource "azurerm_subnet" "internal" {
    address_prefix                                 = "10.0.1.0/24"
    address_prefixes                               = [
        "10.0.1.0/24",
    ]
    enforce_private_link_endpoint_network_policies = false
    enforce_private_link_service_network_policies  = false
    id                                             = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp/subnets/internal_virtsubnet"
    name                                           = "internal_virtsubnet"
    resource_group_name                            = "deploy_webpage_rg"
    service_endpoints                              = []
    virtual_network_name                           = "vir_net_webapp"
}


# module.network_security_group.azurerm_network_security_group.example:
resource "azurerm_network_security_group" "example" {
    id                  = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage"
    location            = "westus2"
    name                = "network_secgroup_webpage"
    resource_group_name = "deploy_webpage_rg"
    security_rule       = []
    tags                = {
        "environment" = "Production"
    }
}

# module.network_security_group.azurerm_network_security_rule.example1:
resource "azurerm_network_security_rule" "example1" {
    access                      = "Allow"
    destination_address_prefix  = "10.0.0.0/16"
    destination_port_range      = "22"
    direction                   = "Inbound"
    id                          = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule1"
    name                        = "secrule1"
    network_security_group_name = "network_secgroup_webpage"
    priority                    = 200
    protocol                    = "Tcp"
    resource_group_name         = "deploy_webpage_rg"
    source_address_prefix       = "10.0.0.0/16"
    source_port_range           = "22"
}

# module.network_security_group.azurerm_network_security_rule.example2:
resource "azurerm_network_security_rule" "example2" {
    access                      = "Allow"
    destination_address_prefix  = "10.0.0.0/16"
    destination_port_range      = "80"
    direction                   = "Inbound"
    id                          = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule2"
    name                        = "secrule2"
    network_security_group_name = "network_secgroup_webpage"
    priority                    = 300
    protocol                    = "Tcp"
    resource_group_name         = "deploy_webpage_rg"
    source_address_prefix       = "10.0.0.0/16"
    source_port_range           = "80"
}

# module.network_security_group.azurerm_network_security_rule.example3:
resource "azurerm_network_security_rule" "example3" {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = "*"
    direction                   = "Outbound"
    id                          = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule3"
    name                        = "secrule3"
    network_security_group_name = "network_secgroup_webpage"
    priority                    = 400
    protocol                    = "Tcp"
    resource_group_name         = "deploy_webpage_rg"
    source_address_prefix       = "*"
    source_port_range           = "*"
}

# module.network_security_group.azurerm_network_security_rule.example4:
resource "azurerm_network_security_rule" "example4" {
    access                      = "Allow"
    destination_address_prefix  = "10.0.0.0/16"
    destination_port_range      = "443"
    direction                   = "Inbound"
    id                          = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule4"
    name                        = "secrule4"
    network_security_group_name = "network_secgroup_webpage"
    priority                    = 500
    protocol                    = "Tcp"
    resource_group_name         = "deploy_webpage_rg"
    source_address_prefix       = "10.0.0.0/16"
    source_port_range           = "*"
}


# module.resource_group.azurerm_resource_group.test:
resource "azurerm_resource_group" "test" {
    id       = "/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg"
    location = "westus2"
    name     = "deploy_webpage_rg"
    tags     = {}
}
(.deploy-webserver) [casita@localhost test]$ 
```

Another spected output could be the following:

```bash
(.deploy-webserver) [casita@localhost test]$ terraform apply
Acquiring state lock. This may take a few moments...
module.resource_group.azurerm_resource_group.test: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg]
module.network_security_group.azurerm_network_security_rule.example1: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule1]
module.network_security_group.azurerm_network_security_rule.example4: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule4]
module.network_security_group.azurerm_network_security_group.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage]
module.availability_set_virtual_machines.azurerm_availability_set.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/availabilitySets/AvailabilitySet]
module.network_security_group.azurerm_network_security_rule.example3: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule3]
module.virtual_network.azurerm_virtual_network.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp]
module.public_ip.azurerm_public_ip.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/publicIPAddresses/publicIP]
module.network_security_group.azurerm_network_security_rule.example2: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkSecurityGroups/network_secgroup_webpage/securityRules/secrule2]
module.virtual_subnet.azurerm_subnet.internal: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/virtualNetworks/vir_net_webapp/subnets/internal_virtsubnet]
module.load_balancer.azurerm_lb.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer]
module.network_interface.azurerm_network_interface.example[1]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1]
module.network_interface.azurerm_network_interface.example[0]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0]
module.load_balancer.azurerm_lb_nat_rule.example2: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPAccess]
module.load_balancer.azurerm_lb_nat_rule.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/HTTPSAccess]
module.load_balancer.azurerm_lb_nat_rule.example3: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/inboundNatRules/SSHAccess]
module.load_balancer.azurerm_lb_backend_address_pool.example: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool]
module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[0]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-0/ipConfigurations/internal|/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool]
module.load_balancer.azurerm_network_interface_backend_address_pool_association.example[1]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/networkInterfaces/network_interface-nic-1/ipConfigurations/internal|/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Network/loadBalancers/WebPage-LoadBalancer/backendAddressPools/acctestpool]
module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[0]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-0]
module.availability_set_virtual_machines.azurerm_linux_virtual_machine.main[1]: Refreshing state... [id=/subscriptions/c605f0e1-a75b-420d-a031-45699271f410/resourceGroups/deploy_webpage_rg/providers/Microsoft.Compute/virtualMachines/vm-1]

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...
(.deploy-webserver) [casita@localhost test]$ 
```