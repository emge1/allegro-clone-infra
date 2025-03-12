module "aws_infrastructure" {
  source = "./aws"

  project_name = var.project_name
  aws_region   = var.aws_region
}

resource "azurerm_resource_group" "rg" {
  name     = "my-ui-resource-group"
  location = "East US"
}

resource "azurerm_static_site" "ui" {
  name                = "my-ui-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
