terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.42.0"
    }
     azuread = {
      source  = "hashicorp/azuread"
      version = "3.8.0"
    }
     kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
  required_version = ">=1.9.0"
}
provider "kubernetes" {
  # Configuration options
}
provider "azuread" {
  # Configuration options
}
provider "azurerm" {
    features {
      key_vault {
      recover_soft_deleted_key_vaults = false
      purge_soft_delete_on_destroy    = true
    }
    }
}
provider "vault" {
  # Configuration options
}