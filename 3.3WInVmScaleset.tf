# resource "azurerm_windows_virtual_machine" "mylinuxvm" {
#   name = "mywinVm-1"
#   computer_name = "mywinVm-vm1" #hostname of the vm
#   resource_group_name = azurerm_resource_group.myrg.name
#   location = azurerm_resource_group.myrg.location
#   size = "Standard_F2"
#   #disable_password_authentication=false
#   admin_username = "azureuser"
#   network_interface_ids = [azurerm_network_interface.myvmnic.id]
#   admin_password = "Levelup@0079374"

resource "azurerm_windows_virtual_machine_scale_set" "mylinuxvm" {
  name = "mywinVm-1"
  #computer_name = "mywinVm-vm1" #hostname of the vm
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "azureuser"
  admin_password      = "Levelup@0079374"
  # network_interface_ids = [azurerm_network_interface.myvmnic.id]
  network_interface {
    name    = "vmnic"
    primary = true
    ip_configuration {
      name                          = "internal"
      subnet_id                     = azurerm_subnet.mysubnet.id
      primary = true
      public_ip_address {
        name = "Ipconfig"
        public_ip_prefix_id = azurerm_public_ip.mypublicip.id

      }
    }
  }

  os_disk {
    # name="osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}
