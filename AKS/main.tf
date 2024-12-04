# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Define the Azure Resource Group
resource "azurerm_resource_group" "helloworld" {
  name     = "helloworld-aks-rg"
  location = "East US"
}

# Define the Azure Virtual Network
resource "azurerm_virtual_network" "helloworld" {
  name                = "helloworld-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.helloworld.location
  resource_group_name = azurerm_resource_group.helloworld.name
}

# Define the Azure Subnet
resource "azurerm_subnet" "helloworld" {
  name                 = "helloworld-subnet"
  resource_group_name  = azurerm_resource_group.helloworld.name
  virtual_network_name = azurerm_virtual_network.helloworld.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create the Service Principal for AKS
resource "azurerm_azuread_service_principal" "helloworld" {
  application_id = azurerm_azuread_application.helloworld.application_id
}

# Create the Azure Active Directory Application
resource "azurerm_azuread_application" "helloworld" {
  name                       = "helloworld-aks-sp"
  owners                     = ["<your-email@helloworld.com>"]
  homepage                   = "http://helloworld.com"
  identifier_uris            = ["http://helloworld.com/aks"]
}

# Define the AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "helloworld-aks-cluster"
  location            = azurerm_resource_group.helloworld.location
  resource_group_name = azurerm_resource_group.helloworld.name
  dns_prefix          = "helloworldaks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.helloworld.id
  }

  service_principal {
    client_id     = "<your-client-id>"
    client_secret = "<your-client-secret>"
  }

  tags = {
    environment = "dev"
  }

  depends_on = [azurerm_azuread_service_principal.helloworld]
}

# Output the AKS cluster name and kubeconfig
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kubeconfig" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].raw_kube_config
}
