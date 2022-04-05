# Create Public IP
resource "azurerm_public_ip" "panoramapip" {
  name                = "pip-vm-${var.environment}-${var.location}-panorama-${var.countindex}"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create VNICs
resource "azurerm_network_interface" "vnic0" {
  name                = "nic-vm-${var.environment}-${var.location}-panorama-${var.countindex}-vnic0"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "panorama-${var.countindex}"
    subnet_id                     = var.panoramasubid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.panoramapip.id
  }
}

# Create Panorama VM
resource "azurerm_virtual_machine" "panorama" {
  name                = "vm-${var.environment}-${var.location}-panorama-${var.countindex}"
  location            = var.location
  resource_group_name = var.rgname
  vm_size             = var.palovmsize

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  plan {
    name      = var.palosku
    publisher = "paloaltonetworks"
    product   = var.palooffer
  }

  storage_image_reference {
    publisher = "paloaltonetworks"
    offer     = var.palooffer
    sku       = var.palosku
    version   = var.paloversion
  }

  storage_os_disk {
    name              = "disk-os-vm-${var.environment}-${var.location}-panorama-${var.countindex}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "127"
  }

  os_profile {
    computer_name  = "vm-${var.environment}-${var.location}-panorama-${var.countindex}"
    admin_username = var.palouser
    admin_password = var.palopass
  }

  network_interface_ids        = [azurerm_network_interface.vnic0.id]
  primary_network_interface_id = azurerm_network_interface.vnic0.id

  os_profile_linux_config {
    disable_password_authentication = false
  }
}