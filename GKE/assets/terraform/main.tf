# login to GCP account
# gcloud auth login
# cloud auth application-default login
# gcloud projects list
# gcloud config set project

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

module "network" {
  source = "./network"

  gcp_service_compute   = google_project_service.compute
  gcp_service_container = google_project_service.container

  REGION  = var.REGION
  NETWORK = var.NETWORK
}


