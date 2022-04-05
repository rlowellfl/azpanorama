variable "environment" {
  type = string
}

variable "rgname" {
  type = string
}

variable "location" {
  type = string
}

variable "vnetspace" {
  type = list(string)
}

variable "dnsservers" {
  type = list(string)
}

variable "panoramasubrange" {
  type = list(string)
}

variable "allowedips" {
  type = list(string)
}