provider "azurerm" {
  features {}

  subscription_id = "a0ec7f91-2412-4043-9058-feb7240b11bc" 
}

resource "azurerm_resource_group" "chaitanya_rg" {
  name     = "chaitanya-rg"
  location = var.location
}

resource "azurerm_virtual_network" "chaitanya_vnet" {
  name                = "chaitanya-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.chaitanya_rg.name
}

resource "azurerm_subnet" "chaitanya_subnet" {
  name                 = "chaitanya-subnet"
  resource_group_name  = azurerm_resource_group.chaitanya_rg.name
  virtual_network_name = azurerm_virtual_network.chaitanya_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "chaitanya_nsg" {
  name                = "chaitanya-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.chaitanya_rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "chaitanya_nsg_assoc" {
  subnet_id                 = azurerm_subnet.chaitanya_subnet.id
  network_security_group_id = azurerm_network_security_group.chaitanya_nsg.id
}

resource "azurerm_public_ip" "chaitanya_ip" {
  name                = "chaitanya-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.chaitanya_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "chaitanya_nic" {
  name                = "chaitanya-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.chaitanya_rg.name

  ip_configuration {
    name                          = "chaitanya-ipconfig"
    subnet_id                     = azurerm_subnet.chaitanya_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.chaitanya_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "chaitanya_vm" {
  name                = "chaitanya-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.chaitanya_rg.name
  network_interface_ids = [azurerm_network_interface.chaitanya_nic.id]
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
