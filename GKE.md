# Install GKE

## Access

gcloud auth login
gcloud container clusters get-credentials labcluster --zone us-central1-c --project golden-plateau-358415

https://stackoverflow.com/questions/72274548/how-to-remove-warning-in-kubectl-with-gcp-auth-plugin


ej:
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
gcloud container clusters get-credentials labcluster --zone us-central1-c --project golden-plateau-358415
