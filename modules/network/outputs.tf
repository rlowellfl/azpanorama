output "vnetname" {
  value = azurerm_virtual_network.vnet.name
}

output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}

output "panoramasubid" {
  value = azurerm_subnet.panorama.id
}

output "panoramasubiprange" {
  value = join("", azurerm_subnet.panorama.address_prefixes)
}