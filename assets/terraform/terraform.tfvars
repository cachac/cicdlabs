PROJECT_ID = "golden-plateau-358415"
REGION     = "us-east1"
NETWORK = {
  NETWORK_NAME     = "gke-network01"
  SUBNET_NAME      = "kube-private01"
  CIDR             = "10.0.0.0/18"
  POD_IP_RANGE     = "10.48.0.0/14"
  SERVICE_IP_RANGE = "10.52.0.0/20"
}
GKE = {
  CLUSTER_NAME = "cicd01"
  ZONE         = "us-east1-b"
  NODE_COUNT   = 2
  MACHINE_TYPE = "e2-small" # e2-medium

  FILESTORE = true # NFS
}
