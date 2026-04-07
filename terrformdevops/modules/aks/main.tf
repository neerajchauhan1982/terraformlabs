data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false  
}
 resource "random_string" "name_suffix" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name = substr(lower("${var.cluster_name}-${random_string.name_suffix.result}") , 0, 12)
  location              = var.location
  resource_group_name   = var.rg
  dns_prefix            = "${var.rg}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.rg}-nrg"
  oidc_issuer_enabled = true
  
  default_node_pool {
    name       = substr(lower("${var.node_pool_name}${random_string.name_suffix.result}"), 0, 12)
    vm_size    = "standard_d2d_v4"
    zones   = [1, 2, 3]
    auto_scaling_enabled = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"

  }

  service_principal  {
    client_id = var.client_id
    client_secret = var.client_secret
  }

# to do: generate the ssh keys using tls_private_key
# upload the key to key vault

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
        key_data = trimspace(var.ssh_public_key)
    }
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

    
  }