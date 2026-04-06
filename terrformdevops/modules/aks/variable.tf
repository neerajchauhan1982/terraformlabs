variable "location" {

}
 variable "rg" {}

variable "service_principal_name" {
  type = string
}

variable "ssh_public_key" {
  default = "c:/Users/chauh/.ssh/azure_vm_rsa.pub"
}

variable "client_id" {}
variable "client_secret" {
  type = string
  sensitive = true
}

variable "node_pool_name" {
  
}
variable "cluster_name" {
  
}