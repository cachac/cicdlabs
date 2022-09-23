output "network_link" {
  value = google_compute_network.main.self_link
}

output "subnet_link" {
  value = google_compute_subnetwork.private.self_link
}
