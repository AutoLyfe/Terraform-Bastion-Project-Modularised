# virtual-machine module1
resource "azurerm_windows_virtual_machine" "vm1" {
    name                  = var.vmname1
    resource_group_name   = var.resource_group_name
    location              = var.location
    size                  = var.vm_size
    admin_username        = var.admin_usename
    admin_password        = var.admin_password
    network_interface_ids = [azurerm_network_interface.nic1.id]
    os_disk {
        name                    = "${var.vmname1}-os-disk-01"
        caching                 = "ReadWrite"
        storage_account_type    = var.os_disk_type
    }
    source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = "latest"
    }
}


# main.tf file of network-interface module
resource "azurerm_network_interface" "nic1" {
    name                = "${var.vmname1}-nic-01"
    location            = var.location
    resource_group_name = var.resource_group_name
    ip_configuration {
        name                          = "ipconfiguration1"
        subnet_id                     = var.subnet1_id
        private_ip_address_allocation = "Dynamic"
    }
}



#  virtual-machine module2
resource "azurerm_windows_virtual_machine" "vm2" {
    name                  = var.vmname2
    resource_group_name   = var.resource_group_name
    location              = var.location
    size                  = var.vm_size
    admin_username        = var.admin_usename
    admin_password        = var.admin_password
    network_interface_ids = [azurerm_network_interface.nic2.id]
    os_disk {
        name                    = "${var.vmname2}-os-disk-02"
        caching                 = "ReadWrite"
        storage_account_type    = var.os_disk_type
    }
    source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = "latest"
    }
}


# main.tf file of network-interface module
resource "azurerm_network_interface" "nic2" {
    name                = "${var.vmname2}-nic-02"
    location            = var.location
    resource_group_name = var.resource_group_name
    ip_configuration {
        name                          = "ipconfiguration1"
        subnet_id                     = var.subnet2_id
        private_ip_address_allocation = "Dynamic"
    }
}