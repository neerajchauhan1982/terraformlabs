resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}
module "service_principle_name" {
  source                 = "../modules/spn"
  service_Principle_Name = var.service_principle_name
  depends_on = [
    azurerm_resource_group.rg
  ]
}
resource "azurerm_role_assignment" "rolespn" {

  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.service_principle_name.object_id

  depends_on = [
    module.service_principle_name
  ]
}
resource "azurerm_role_assignment" "rolekv" {

  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = module.service_principle_name.object_id
  depends_on = [
    module.service_principle_name
  ]
}

module "keyvault" {
  source        = "../modules/keyvault"
  keyvault_name = var.keyvault_name
  location      = var.location
  rg            = var.rg
  depends_on = [
    azurerm_role_assignment.rolekv
  ]
}

resource "azurerm_key_vault_secret" "example" {
  name         = module.service_principle_name.client_id
  value        = module.service_principle_name.client_secret
  key_vault_id = module.keyvault.keyvault_id

  depends_on = [
    module.keyvault
  ]
}

#create Azure Kubernetes Service
module "aks" {
  ssh_public_key         = tls_private_key.vm1.public_key_openssh
  source                 = "../modules/aks/"
  service_principal_name = var.service_principle_name
  client_id              = module.service_principle_name.client_id
  client_secret          = module.service_principle_name.client_secret
  location               = var.location
  rg                     = var.rg
  cluster_name           = var.cluster_name
  node_pool_name         = var.node_pool_name

  depends_on = [
    module.service_principle_name
  ]

}

resource "local_file" "kubeconfig" {
  depends_on = [module.aks]
  filename   = "./kubeconfig"
  content    = module.aks.aks_config

}
resource "tls_private_key" "vm1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "random_string" "ran_id" {
    length = 5
    upper = false
    special = false
}
resource "azurerm_key_vault_secret" "vm1_ssh_public_key" {
  name         = substr(replace(lower("${var.public}-${random_string.ran_id.result}"), "_", "-"), 0, 63)
  value        = tls_private_key.vm1.public_key_openssh
  key_vault_id = module.keyvault.keyvault_id
  depends_on = [
    module.keyvault
  ]
}
resource "azurerm_key_vault_secret" "vm1_ssh_private_key" {
  name         = substr(replace(lower("${var.private}-${random_string.ran_id.result}"), "_", "-"), 0, 63)
  value        = tls_private_key.vm1.private_key_openssh
  key_vault_id = module.keyvault.keyvault_id
  depends_on = [
    module.keyvault
  ]
}