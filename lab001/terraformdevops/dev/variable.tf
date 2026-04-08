variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "service_principle_name" {
  type = string
}
variable "SUB_ID" {
  type = string
}
variable "keyvault_name" {
  type = string
}

variable "node_pool_name" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "public" {
  type = string
  default = "vm"
}
variable "private" {
 type = string
 default = "vm"
}