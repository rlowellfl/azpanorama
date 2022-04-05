/*
BEFORE DEPLOYING PANORAMA
Using the Az CLI, accept the offer terms prior to deployment. This only
need to be done once per subscription
```
az vm image terms accept --urn paloaltonetworks:panorama:byol:10.1.3

```
*/

# Configure Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
/*  backend "azurerm" {
    resource_group_name  = "<rg for terraform state backend storage>"
    storage_account_name = "<storage account for terraform state backend storage>"
    container_name       = "panoramatfstate"
    key                  = "<storage account key>"
  }
*/
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "network" {
  name     = "rg-${var.environment}-${var.location}-panorama"
  location = var.location
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
  vnetid        = module.network.networkid
  panoramasubid = module.network.panoramasubid
}