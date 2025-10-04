# Public IP لـ Azure Bastion
resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.project_name}-bastion-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.project_name}-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku               = "Standard" # ← مهم (Basic ما يدعم native client)
  tunneling_enabled = true       # ← هذا هو Native client
  # اختياري:
  # ip_connect_enabled    = true
  # shareable_link_enabled = true
  # scale_units           = 2

  ip_configuration {
    name                 = "bastion-ipcfg"
    subnet_id            = azurerm_subnet.snet["bastion"].id # AzureBastionSubnet
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

# NIC لِـ VM الإدارة داخل Subnet mgmt
resource "azurerm_network_interface" "nic_mgmt" {
  name                = "${var.project_name}-nic-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.snet["mgmt"].id
    private_ip_address_allocation = "Dynamic"
  }
}

# cloud-init بسيط يثبت ansible + git على VM الإدارة
locals {
  mgmt_cloud_init = <<-CLOUD
  #cloud-config
  package_update: true
  packages:
    - ansible
    - git
  runcmd:
    - timedatectl set-timezone Asia/Riyadh
  CLOUD
}

# VM الإدارة (بدون Public IP)
resource "azurerm_linux_virtual_machine" "vm_mgmt" {
  name                  = "${var.project_name}-vm-mgmt"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic_mgmt.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  # استخدمي نفس المفتاح العام اللي أنشأتِ به بقية الـVMs
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  custom_data = base64encode(local.mgmt_cloud_init)
}
