# variables.tf file of virtual-machine module
variable "vmname1" {
    type = string
    description = "The name of the virtual machine"
}

variable "vmname2" {
    type = string
    description = "The name of the virtual machine"
}

variable "resource_group_name" {
    type = string
    description = "The name of resource group"
}
variable "location" {
    type = string
    description = "Azure location "
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
}
variable "image_offer" {
    type = string
    description = "Azure image offer"
}
variable "image_sku" {
    type = string
    description = "Azure image sku"
}

# variables.tf file of network-interface module

variable "subnet1_id" {
    type = string
    description = "id of the subnet"
}

variable "subnet2_id" {
    type = string
    description = "id of the subnet"
}