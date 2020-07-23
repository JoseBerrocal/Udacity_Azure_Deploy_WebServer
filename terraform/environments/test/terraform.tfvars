# Azure subscription vars
subscription_id = "010976de-a175-413a-84be-6f56f4caec91"
client_id = "bdef5e95-4688-4031-83e6-10a337bb9b59"
client_secret = "/S^dl2@%f6Fo5|)GmUkh8+Huf=\"OUx:'"
tenant_id = "ff1217c8-dc0a-4f38-ba01-96beee1ab324"

# Resource Group/Location
location = "West US 2"
resource_group = "rg_deploy_webpage"

# Virtual Network
virtual_network = "vir_net_webapp"
address_space = ["10.0.0.0/16"]

# Virtual SubNetwork
virtual_subnet = "internal_virtsubnet"
address_prefix = "10.0.1.0/24"

# Network Security Group
network_security_group = "network_secgroup_webpage"

# Network Interface
network_interface = "network_interface"

# Public IP
public_ip_name = "publicIP"

#resource_type = "AppService"
application_type = "AzureJBmyApplication1" # This name has to be globally unique.

# Tags
tier = "Test"
deployment = "Terraform"