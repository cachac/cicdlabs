# cicdlabs
github actions + kubernetes + ArgoCd

# Draw.io
## Account
# github
## create account
## add ssh keys
## create private repo: Apps
## add repo to local
```vim
git init
git remote add origin ssh-link
git pull origin main
```
## add App kubelabs and push
- Git clone kubelabs repo
- copy dev/public-api folder
```vim
git add .
git commit -m 'init'
git push
```
## build docker container
```vim
source .env.qa
echo $APP_ENV_KUBE_API
export REGISTRY=cachac
export $API_NAME=cachac/kubelabs_publicapi
export $VERSION=1.0.0

docker build . -f qa.dockerfile -t $REGISTRY/$API_NAME:$VERSION --build-arg APP_ENV="$APP_ENV_KUBE_API"
docker push $REGISTRY/$API_NAME:$VERSION
# test
docker run --rm --name api -p 3080:3080 $REGISTRY/$API_NAME:$VERSION
curl localhost:3080/healthcheck
```

# DockerHub
## Create Account
## publish repo
> [login](https://docs.docker.com/engine/reference/commandline/login/)
```vim
docker login
docker push $REGISTRY/$API_NAME:$VERSION
```
## make private

# Install Kubernetes Cluster
## gmail accounts
## GKE
> [GKE](./GKE.md)
# Kubernetes definitions files
## create second private git repo: deploy
## add repo to local
## public api yamls
- ns public
- cm
- deploy (image name and version)
- registry access
> [info](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)
```vim
kubectl config set-context --current --namespace=public

export DOCKER_PATH=<path/to/.docker/config.json>

kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=$DOCKER_PATH \
    --type=kubernetes.io/dockerconfigjson \
    -n public


kubectl get secret regcred
```
- agregar al deploy.yaml
```yaml
	imagePullSecrets:
	- name: regcred
```
- svc
- Ingress (static ip-address)
```vim
gcloud compute addresses create api-static-ip --global
```
annotations:
    kubernetes.io/ingress.global-static-ip-name: "api-static-ip"

-  (change USERLAB)

## Check VPC Network static-ip
- In use by: ingress

## check ingress
> [unhealthy backends](https://www.anycodings.com/questions/gke-ingress-shows-unhealthy-backend-services)
```vim
kubectl get ing
# check address
```
## check GCP console LB

## add DNS records
> [multi LB](https://cloud.google.com/kubernetes-engine/docs/tutorials/http-balancer)
> [dns](https://medium.com/google-cloud/dns-on-gke-everything-you-need-to-know-b961303f9153)
> [external dns](https://joachim8675309.medium.com/externaldns-with-gke-cloud-dns-38a174fdced7)

- api.USERLAB.kubelabs.tk
- Add external Static IP

## test URL api
- /
- /graphql
- curl http://api.cachac.kubelabs2.tk
-
# SSL/TLS
https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-features#https_redirect

- create managed cert
- delete ingress
- front-end config  -  ssl redirect
- update ingress class and cert

  annotations:
    kubernetes.io/ingress.global-static-ip-name: "api-static-ip"
    networking.gke.io/managed-certificates: managed-cert
    kubernetes.io/ingress.class: "gce"
		# redirect
    kubernetes.io/ingress.allow-http: "false"
    networking.gke.io/v1beta1.FrontendConfig: lb-http-to-https

https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs

# Storage
- vol.yml (1 node - many pods)
- deploy vol, 1 pod running - 1 pod pending
- filestore
> [Filestore](./Filestore.md)
> [info](https://upendra-kumarage.medium.com/gcp-filestore-as-a-persistent-storage-in-google-kubernetes-engine-clusters-ab4f76b34118)
- assets/filestoreVolumen.yaml
- Optional: assets/filestoreStorageClass.yaml
- update deploy vol: filestore-public-api
## kustomize api
## delete public ns
```vim
kubectl delete ns public --force --grace-period=0

# forzar el "finalizer"
export NS=public &&
kubectl get namespace "${NS}" -o json \
  | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw /api/v1/namespaces/${NS}/finalize -f -
```
### folder structure
- base
- overlays
- - stage
- - production

### build
```vim
kustomize build overlays/stage
```
### apply
```vim
kubectl apply -k overlay/stage
```


> [file definitions](./assets/kustomize/)
# GitOps: ArgoCD

# Github Actions




# last: Create all apps and create git  .md (portfolio)
