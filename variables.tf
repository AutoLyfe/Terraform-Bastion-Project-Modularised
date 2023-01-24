variable "resource_group_name" {
    type = string
    description = "resource group name of the virtual network"
}
variable "location" {
    type = string
    description = "location of the virtual network"
}

#VNET Variables
variable "virtual1_network_name" {
    type = string
    description = "name of the virtual network"
}

variable "virtual2_network_name" {
    type = string
    description = "name of the virtual network"
}

variable "virtual1_network_address_space" {
    type = string
    description = "address space of the virtual network"
}

variable "virtual2_network_address_space" {
    type = string
    description = "address space of the virtual network"
}

variable "subnet1_name" {
    type = string
    description = "name of the subnet"
}

variable "subnet2_name" {
    type = string
    description = "name of the subnet"
}
variable "subnet1_address_prefix" {
    type = string
    description = "address prefix of the subnet"
}

variable "subnet2_address_prefix" {
    type = string
    description = "address prefix of the subnet"
}


#VM Variables

variable "vmname1" {
    type = string
    description = "The name of the virtual machine"
}

variable "vmname2" {
    type = string
    description = "The name of the virtual machine"
}
variable "vm_size" {
    type = string
    description = "size of the virtual machine"
}
variable "os_disk_type" {
    type = string
    description = "type of the os disk. example Standard_LRS"
}
variable "admin_usename" {
    type = string
    description = "local admin user of the virtual machine"
}
variable "admin_password" {
    type = string
    description = "password of the local admin user"
}
variable "image_publisher" {
    type = string
    description = "Azure image publisher"
    default = "MicrosoftWindowsServer"
}
variable "image_offer" {
    type = string
    description = "Azure image offer"
    default = "WindowsServer"
}
variable "image_sku" {
    type = string
    description = "Azure image sku"
    default = "2016-Datacenter"
}


# Prefix for bastion and Tags

variable "prefix" {
  description = "Prefix to append to all resource names"
  type        = string
  default     = "tfdemo"
}

variable "tags" {
  description = "Resouce tags"
  type        = map(string)
  default = {
    "project"       = "tfdemo"
    "deployed_with" = "Terraform"
  }
}


# Bastion Subnet and name
variable "bastion_subnet_address_range" {
  description = "IP Range of the virtual network"
  type        = string
}


variable "bastion_subnet_name" {
  description = "The name of the bastion host"
  type        = string
}
