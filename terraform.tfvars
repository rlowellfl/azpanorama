# Environmental variables
environment = "test"
location    = "eastus2"

# Panorama VNet variables
vnetspace        = ["10.0.0.0/24"]
dnsservers       = ["8.8.8.8", "8.8.4.4"]
panoramasubrange = ["10.0.0.0/27"]
allowedips       = ["<your public ip here>"]

# Palo Alto Panorama variables
palodeploycount = "1"
palovmsize      = "Standard_D4s_v4"
palooffer       = "panorama"
palosku         = "byol"
paloversion     = "10.1.3"
palouser        = "azpanorama"
palopass        = "<panorama password>"