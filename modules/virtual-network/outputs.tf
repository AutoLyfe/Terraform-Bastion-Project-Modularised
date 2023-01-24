output "subnet1_id" {
    description = "id of the subnet"
    value = azurerm_subnet.subnet1.id
}

output "subnet2_id" {
    description = "id of the subnet"
    value = azurerm_subnet.subnet2.id
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "network_security_group_id" {
  value       = azurerm_network_security_group.nsg.id
}


output "bastion_pip" {
  value       = azurerm_public_ip.pip.id
}
