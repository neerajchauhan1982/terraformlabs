data "azuread_client_config" "current" {}

resource "azuread_application" "myappusr" {
  display_name = var.service_Principle_Name
  owners       = [data.azuread_client_config.current.object_id]
}
resource "azuread_service_principal" "spn" {
  client_id                    = azuread_application.myappusr.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}
resource "azuread_service_principal_password" "pass" {
  service_principal_id = azuread_service_principal.spn.id
}