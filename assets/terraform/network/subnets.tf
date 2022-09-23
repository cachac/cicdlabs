# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = lookup(var.NETWORK, "SUBNET_NAME")
  ip_cidr_range            = lookup(var.NETWORK, "CIDR")
  region                   = var.REGION
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = lookup(var.NETWORK, "POD_IP_RANGE")
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = lookup(var.NETWORK, "SERVICE_IP_RANGE")
  }
}
