
provider "azurerm" {
  version = "1.27.0"
}
resource "azurerm_resource_group" "azure_rg" {
  name     =  var.rgname
  location =  var.location
}
