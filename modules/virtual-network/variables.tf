variable "resource_group_name" {
    type = string
    description = "resource group name of the virtual network"
}
variable "location" {
    type = string
    description = "location of the virtual network"
}
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


# Prefix and Tags

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


# Bastion Subnet
variable "bastion_subnet_address_range" {
  description = "IP Range of the virtual network"
  type        = string
}


variable "bastion_subnet_name" {
  description = "The name of the bastion host"
  type        = string
}