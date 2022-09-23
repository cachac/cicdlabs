https://cloud.google.com/community/tutorials/gke-filestore-dynamic-provisioning

gcloud services enable file.googleapis.com

FS=[NAME FOR THE FILESTORE YOU WILL CREATE]
NETWORK=kube

gcloud beta filestore instances create ${FS} \
  --project=${PROJECT_ID} \
  --zone=${ZONE} \
  --tier=STANDARD \
  --file-share=name="volumes",capacity=1TB \
  --network=name=${NETWORK}

# $200/mo

FSADDR=$(gcloud beta filestore instances describe ${FS} \
  --project=${PROJECT_ID} \
  --zone=${ZONE} \
  --format="value(networks.ipAddresses[0])")

ACCOUNT=$(gcloud config get-value core/account)
echo $ACCOUNT $FSADDR





