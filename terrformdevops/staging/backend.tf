terraform {
  backend "azurerm" {
    resource_group_name  = "tfbackend"
    storage_account_name = "storage19821983"
    container_name       = "tfstage"
    key                  = "stage.terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
   subscription_id = var.SUB_ID
}