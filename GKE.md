# Install GKE
> [Terraform](./assets/terraform/main.tf)
# gmail accounts
## add users
# VPC Network (see GCP project)

# New cluster
- zonal: us-east1-b
- release channel
- default-pool:
- - Nodes: spot?
- Cluster:
- - Automation: node autoscaling, node pool locations
- - Networking: vpc network - private subnet - private cluster (172.16.0.0/28) - Enable control plane authorized networks (OPTIONAL)
- - features: Enable Filestore CSI
## Access

```vim
PROJECT_ID=golden-plateau-358415
CLUSTER=cicd01
ZONE=us-east1-b

echo $PROJECT_ID $CLUSTER $ZONE

curl https://sdk.cloud.google.com | bash
gcloud auth login
gcloud config set project $PROJECT_ID

# auth plugin
# gcloud components install gke-gcloud-auth-plugin
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

export USE_GKE_GCLOUD_AUTH_PLUGIN=True
gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT_ID
```

> [auth plugin warn](https://stackoverflow.com/questions/72274548/how-to-remove-warning-in-kubectl-with-gcp-auth-plugin)

# Grant Roles
