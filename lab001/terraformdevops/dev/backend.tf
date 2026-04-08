terraform {
  backend "azurerm" {
    resource_group_name  = "tfbackend"
    storage_account_name = "storage19821983"
    container_name       = "tfdev"
    key                  = "dev.terraform.tfstate"
  }
}
