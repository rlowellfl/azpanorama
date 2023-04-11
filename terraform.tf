# Configure Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.1.0"
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