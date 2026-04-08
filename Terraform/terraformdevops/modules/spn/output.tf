output "service_principle_Name" {
value = azuread_service_principal.spn.display_name
}
output "tanant_id" {
  value = azuread_service_principal.spn.application_tenant_id
}
output "object_id" {
  value = azuread_service_principal.spn.object_id
}
output "client_id" {
  value = azuread_application.myappusr.client_id
}
output "client_secret" {
  value = azuread_service_principal_password.pass.value
}