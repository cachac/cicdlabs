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
```vim
docker login
docker push $REGISTRY/$API_NAME:$VERSION
```
## make private


# Install Kubernetes Cluster
## GKE
# Kubernetes definitions files
## create second private git repo: deploy
## add repo to local
## public api yamls
- deploy
- svc
- ing (change USERLAB)
## kustomize api
# GitOps: ArgoCD

# Github Actions




# last: Create all and create git  .md (portfolio)
