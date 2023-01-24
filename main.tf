terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }
}

provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "my-rg" {
  name     = var.resource_group_name
  location = var.location
}


module "virtual-network" {
source = "./modules/virtual-network"
virtual1_network_name            = var.virtual1_network_name
virtual2_network_name            = var.virtual2_network_name
resource_group_name             = var.resource_group_name
location                        = var.location
virtual1_network_address_space   = var.virtual1_network_address_space
virtual2_network_address_space   = var.virtual2_network_address_space
subnet1_name                     = var.subnet1_name
subnet2_name                     = var.subnet2_name
subnet1_address_prefix           = var.subnet1_address_prefix
subnet2_address_prefix           = var.subnet2_address_prefix
bastion_subnet_address_range    = var.bastion_subnet_address_range
bastion_subnet_name             = var.bastion_subnet_name

}



module "virtual-machine" {
    source = "./modules/virtual-machine"
    vmname1                 = var.vmname1
    vmname2                 = var.vmname2
    location                = var.location
    resource_group_name     = var.resource_group_name
    vm_size                 = var.vm_size
    os_disk_type            = var.os_disk_type
    admin_usename           = var.admin_usename
    admin_password          = var.admin_password
    image_publisher         = var.image_publisher
    image_offer             = var.image_offer
    image_sku               = var.image_sku
    subnet1_id              = module.virtual-network.subnet1_id
    subnet2_id              = module.virtual-network.subnet2_id
}