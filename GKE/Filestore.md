# 1. FileStore NFS <!-- omit in toc-->
>[incof](https://cloud.google.com/community/tutorials/gke-filestore-dynamic-provisioning)

> $200/mo
# 2. Enable api
```vim
gcloud services enable file.googleapis.com
```

# 3. Create  NFS
```vim
FS=[NAME FOR THE FILESTORE YOU WILL CREATE]
NETWORK=gke-network01
PROJECT_ID=[PROJECT NAME]
ZONE=useast1-b

echo $FS - $NETWORK - PROJECT_ID - $ZONE

gcloud beta filestore instances create ${FS} \
  --project=${PROJECT_ID} \
  --zone=${ZONE} \
  --tier=STANDARD \
  --file-share=name="volumes",capacity=1TB \
  --network=name=${NETWORK}
```

# 4. Get address
```vim
FSADDR=$(gcloud beta filestore instances describe ${FS} \
  --project=${PROJECT_ID} \
  --zone=${ZONE} \
  --format="value(networks.ipAddresses[0])")

ACCOUNT=$(gcloud config get-value core/account)
echo $ACCOUNT $FSADDR

```






