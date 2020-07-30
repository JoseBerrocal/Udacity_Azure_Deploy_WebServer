# Azure subscription vars
subscription_id = "c605f0e1-a75b-420d-a031-45699271f410"
client_id = "8370efcf-e7ce-4084-9c05-8d07dc2b32a5"
client_secret = ">{x`Gn5vj.#)7\\@y'c_p8hVI/^+X@FXM"
tenant_id = "759b0f8d-2617-4ab1-abd2-fdeeb1fcce0a"

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

# Tags
tier = "Test"
deployment = "Terraform"