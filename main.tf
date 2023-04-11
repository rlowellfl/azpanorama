/*
BEFORE DEPLOYING PANORAMA
Using the Az CLI, accept the offer terms prior to deployment. This only
need to be done once per subscription
```
az vm image terms accept --urn paloaltonetworks:panorama:byol:10.1.3

```
*/

# Create Resource Group
resource "azurerm_resource_group" "network" {
  name     = "rg-${var.environment}-${var.location}-panorama"
  location = var.location
  tags = {
    environment     = var.environment
    location        = var.location
    BusinessUnit    = "IT"
    OpsTeam         = "Network"
    ApplicationName = "${var.location} Palo Alto Panorama"
    Owner           = "john@doe.com"
  }
}

# Deploy the virtual network
module "network" {
  source           = "./modules/network"
  rgname           = azurerm_resource_group.network.name
  location         = azurerm_resource_group.network.location
  environment      = var.environment
  vnetspace        = var.vnetspace
  dnsservers       = var.dnsservers
  panoramasubrange = var.panoramasubrange
  allowedips       = var.allowedips
}

# Deploy one or more Palo Alto Panorama virtual machines
module "panorama" {
  source        = "./modules/panorama"
  rgname        = azurerm_resource_group.network.name
  location      = azurerm_resource_group.network.location
  environment   = var.environment
  count         = var.palodeploycount
  countindex    = count.index
  palovmsize    = var.palovmsize
  palooffer     = var.palooffer
  palosku       = var.palosku
  paloversion   = var.paloversion
  palouser      = var.palouser
  palopass      = var.palopass
  vnetid        = module.network.vnetid
  panoramasubid = module.network.panoramasubid
  bootdiagsname = azurerm_storage_account.bootdiags.primary_blob_endpoint
}