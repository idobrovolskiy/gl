terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "task_1" {
  name     = "task1_resourcegroup"
  location = "eastus"

}



resource "azurerm_public_ip" "task_1" {
  name                = "Task_1"
  location            = "eastus"
  resource_group_name = "task1_resourcegroup"
  allocation_method   = "Static"
}

resource "azurerm_lb" "task_1" {
  name                = "LoadBalancer"
  location            = "eastus"
  resource_group_name = "task1_resourcegroup"


}


resource "azurerm_virtual_network" "task_1" {
  name                = "task_1-network"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "task1_resourcegroup"
}

resource "azurerm_subnet" "task_1" {
  name                 = "az1_subnet"
  resource_group_name  = "task1_resourcegroup"
  virtual_network_name = "task_1-network"
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_network_interface" "task_1" {
  name                = "task_1_nic"
  location            = "eastus"
  resource_group_name = "task1_resourcegroup"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "255.0.0.0"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "Machine_1" {
  name                  = "Machine_1"
  resource_group_name   = "task1_resourcegroup"
  location              = "eastus"
  zone                 = "1"
  size                  = "Standard_F2"
  admin_username        = "admin"
  admin_password        = "admin"
  network_interface_ids = ["az1_subnet"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "Machine_2" {
  name                  = "Machine_1"
  resource_group_name   = "task1_resourcegroup"
  location              = "eastus"
  zone                 = "2"
  size                  = "Standard_F2"
  admin_username        = "admin"
  admin_password        = "admin"
  network_interface_ids = ["az1_subnet"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
