
#
# - Create a Vnet and Subnet
#

resource "azurerm_virtual_network" "vnet1" {
    name                        = var.virtual1_network_name
    resource_group_name         = var.resource_group_name
    location                    = var.location
    address_space               = [var.virtual1_network_address_space]
}
resource "azurerm_subnet" "subnet1" {
    name                    = var.subnet1_name
    resource_group_name     = var.resource_group_name
    virtual_network_name    = azurerm_virtual_network.vnet1.name
    address_prefixes        =[var.subnet1_address_prefix]
}


resource "azurerm_virtual_network" "vnet2" {
    name                        = var.virtual2_network_name
    resource_group_name         = var.resource_group_name
    location                    = var.location
    address_space               = [var.virtual2_network_address_space]
}
resource "azurerm_subnet" "subnet2" {
    name                    = var.subnet2_name
    resource_group_name     = var.resource_group_name
    virtual_network_name    = azurerm_virtual_network.vnet2.name
    address_prefixes        =[var.subnet2_address_prefix]
}



resource "azurerm_virtual_network_peering" "peer-1" {
  name                      = "peer1to2"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "peer-2" {
  name                      = "peer2to1"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}



#
# - Create a Subnet for the Bastion Host
#

resource "azurerm_subnet" "bastion" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.bastion_subnet_address_range]
}


#
# - Create a Bastion Host
#

resource "azurerm_bastion_host" "bastion-host" {
  name                = "${var.prefix}-bastion-host"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}



#
# - Create a Network Security Group
#

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-web-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  security_rule {
    name                       = "Allow_HTTPS_Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = 443
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"

  }


  security_rule {
    name                       = "Allow_GatewayManager_Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = 443
    destination_port_range     = "*"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"

  }

  security_rule {
    name                       = "Allow_BastionCommunication"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = [8080, 5701]
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"

  }


  security_rule {
    name                       = "Allow_SshRdpOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = [22, 3389]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"

  }

  security_rule {
    name                       = "Allow_AzureCloudOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = 443
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "AZureCloud"

  }


  security_rule {
    name                       = "Allow_BastionHostCommunication"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_ranges         = [8080, 5701]
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"

  }

  security_rule {
    name                       = "Allow_GetSessionInformation"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = 80
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"

  }
}


#
# - Subnet-NSG Association
#

resource "azurerm_subnet_network_security_group_association" "subnet-nsg1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_subnet_network_security_group_association" "subnet-nsg2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

#
# - Public IP For The Bastion Host
#

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-bastion-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}