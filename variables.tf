# Environmental variables

variable "environment" {
  description = "Environment for the deployment. Ex: prod, dev, test, sandbox"
  type        = string
}

variable "location" {
  description = "Location for the deployment"
  type        = string
}

# Virtual network variables

variable "vnetspace" {
  description = "The address space of the panorama vnet"
  type        = list(string)
}

variable "dnsservers" {
  description = "The DNS servers of the panorama vnet"
  type        = list(string)
}

variable "panoramasubrange" {
  description = "Virtual network panorama subnet IP range"
  type        = list(string)
}

variable "allowedips" {
  description = "List of allowed source IPs to the Panorama management public IPs"
  type        = list(string)
}

# Palo Alto NVA variables
variable "bootdiagsname" {
  description = "Name of the storage account to store boot diagnostics"
  type        = string
}

variable "palodeploycount" {
  description = "Number of Panorama appliances to deploy"
  type        = string
}

variable "palovmsize" {
  description = "Virtual machine size for the Panorama appliance"
  type        = string
}

variable "palooffer" {
  description = "Offer for the Panorama appliance"
  type        = string
}

variable "palosku" {
  description = "Determines the Palo Alto licensing model. The only valid value is 'byod'"
  type        = string
}

variable "paloversion" {
  description = "Specifies the version of the Panorama appliance to deploy"
  type        = string
}

variable "palouser" {
  description = "Default username for the Panorama appliance"
  type        = string
}

variable "palopass" {
  description = "Default password for the Panorama appliance. This value should be changed after deployment"
  type        = string
}

