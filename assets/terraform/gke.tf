# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  name                     = lookup(var.GKE, "CLUSTER_NAME")
  location                 = lookup(var.GKE, "ZONE")
  remove_default_node_pool = true
  initial_node_count       = lookup(var.GKE, "NODE_COUNT")
  network                  = module.network.network_link
  subnetwork               = module.network.subnet_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  release_channel {
    channel = "REGULAR"
  }

  # Optional, if you want multi-zonal cluster
  # node_locations = [
  #   "us-east1-b"
  # ]

  addons_config {
    # http_load_balancing {
    #   disabled = true
    # }
    horizontal_pod_autoscaling {
      disabled = false
    }
    gcp_filestore_csi_driver_config {
      enabled = lookup(var.GKE, "FILESTORE")
    }

  }

  # workload_identity_config {
  #   workload_pool = "devops-v4.svc.id.goog"
  # }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
