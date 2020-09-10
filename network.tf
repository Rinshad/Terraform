# Virtual Network
resource "azurerm_virtual_network" "vnet" {
    name                 = var.vnet_name
    address_space        = var.address_space
    location             = var.location
    resource_group_name  = var.rgname
}
# Subnet for virtual machine
resource "azurerm_subnet" "vmsubnet" {
  name                  =  var.subnet_name
  address_prefix        =  var.address_prefix
  virtual_network_name  =  var.vnet_name
  resource_group_name   =  var.rgname
}
#Add a Public IP address
resource "azurerm_public_ip" "vmip" {
    count                  = var.numbercount
    name                   = "vm-ip${count.index}"
    resource_group_name    =  var.rgname
    allocation_method      = "Static"
    location               = var.location
}

#Add a Network security group
resource "azurerm_network_security_group" "nsgname" {
    name                   = "vm-nsg"
    location               = var.location
    resource_group_name    =  var.rgname
    
    security_rule {
        name                       = "PORT_SSH"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefixes    = var.external_ip
        destination_address_prefix = "*"
  }
}
#Associate NSG with  subnet
resource "azurerm_subnet_network_security_group_association" "nsgsubnet" {
    subnet_id                    = azurerm_subnet.vmsubnet.id 
    network_security_group_id    = azurerm_network_security_group.nsgname.id 
}

# NIC with Public IP Address
resource "azurerm_network_interface" "terranic" {
    count                  = var.numbercount
    name                   = "vm-nic-${count.index}"
    location               = var.location
    resource_group_name    =  var.rgname
    
    ip_configuration {
        name                          = "external"
        subnet_id                     = azurerm_subnet.vmsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = element(azurerm_public_ip.vmip.*.id, count.index)
  }
  
}