# Create NSGs
resource "azurerm_network_security_group" "panorama" {
  name                = "nsg-${var.environment}-${var.location}-panorama"
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefixes    = var.allowedips
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.allowedips
    destination_address_prefix = "*"
  }
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}-${var.location}-panorama"
  location            = var.location
  resource_group_name = var.rgname
  address_space       = var.vnetspace
  dns_servers         = var.dnsservers
}

# Create subnets and associate network security groups
resource "azurerm_subnet" "panorama" {
  name                 = "panorama"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.panoramasubrange
}

resource "azurerm_subnet_network_security_group_association" "panorama" {
  subnet_id                 = azurerm_subnet.panorama.id
  network_security_group_id = azurerm_network_security_group.panorama.id
}