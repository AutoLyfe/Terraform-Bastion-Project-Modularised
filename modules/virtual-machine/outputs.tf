# outputs.tf file of virtual-machine module
output "vm1_id" {
    description = "id of the fileshare"
    value = azurerm_windows_virtual_machine.vm1.id
}


output "vm2_id" {
    description = "id of the fileshare"
    value = azurerm_windows_virtual_machine.vm2.id
}