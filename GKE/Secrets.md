helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update
helm install sealed-secrets-controller sealed-secrets/sealed-secrets

Download the latest sealed secrets for your distribution from: https://github.com/bitnami-labs/sealed-secrets/releases

And install by following these directions:
https://github.com/bitnami-labs/sealed-secrets/blob/main/README.md#installation


In the example repository, you can look at the folder https://github.com/codefresh-contrib/gitops-secrets-sample-app/tree/main/safe-to-commit and it contains all manifests of the application, including secrets.


kubeseal < unsealed_secrets/db-creds.yml > sealed_secrets/db-creds-encrypted.yaml -o yaml
kubeseal < unsealed_secrets/paypal-cert.yml > sealed_secrets/paypal-cert-encrypted.yaml -o yaml

https://dev.to/stack-labs/store-your-kubernetes-secrets-in-git-thanks-to-kubeseal-hello-sealedsecret-2i6h

multi apps

We already have such example at https://github.com/codefresh-contrib/gitops-certification-examples/tree/main/declarative/multiple-apps.

----
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: demo
  # You'll usually want to add your resources to the argocd namespace.
  namespace: argocd
  # Add a this finalizer ONLY if you want these to cascade delete.
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  # The project the application belongs to.
  project: default

  # Source of the application manifests
  source:
    repoURL: https://github.com/codefresh-contrib/gitops-certification-examples.git
    targetRevision: HEAD
    path: ./declarative/manifests

    # directory
    directory:
      recurse: false
  # Destination cluster and namespace to deploy the application
  destination:
    server: https://kubernetes.default.svc
    namespace: default

  # Sync policy
  syncPolicy:
    automated: # automated sync by default retries failed attempts 5 times with following delays between attempts ( 5s, 10s, 20s, 40s, 80s ); retry controlled using `retry` field.
      prune: true # Specifies if resources should be pruned during auto-syncing ( false by default ).
      selfHeal: true # Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected ( false by default ).
      allowEmpty: false # Allows deleting all application resources during automatic syncing ( false by default ).


Progressive deployment:

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argo-rollouts-controller
spec:
  destination:
    name: ''
    namespace: argo-rollouts
    server: 'https://kubernetes.default.svc'
  source:
    path: ./argo-rollouts-controller
    repoURL: 'https://github.com/cachac/gitops-certification-examples'
    targetRevision: HEAD
  project: default
  syncPolicy:
    automated:
      prune: false
      selfHeal: false



-blue/green
./argo-rollouts-controller

kubectl argo rollouts list rollouts
kubectl argo rollouts status simple-rollout
kubectl argo rollouts get rollout simple-rollout


kubectl argo rollouts set image simple-rollout webserver-simple=docker.io/kostiscodefresh/gitops-canary-app:v2.0
kubectl argo rollouts get rollout simple-rollout
(autoPromotionEnabled: false)
kubectl argo rollouts promote simple-rollout

- canary:

./argo-rollouts-controller
ns: argo-rollouts

kubectl argo rollouts list rollouts
kubectl argo rollouts status simple-rollout
kubectl argo rollouts get rollout simple-rollout
kubectl argo rollouts set image simple-rollout webserver-simple=docker.io/kostiscodefresh/gitops-canary-app:v2.0

Argo Rollouts creates another replicaset with the new version
The old version is still there and gets live/active traffic
The canary version gets 30% of the live traffic.
ArgoCD will mark the application as out-of-sync
ArgoCD will also mark the health of the application as "suspended" because we have setup the new color to wait
At this point the deployment is suspended because we have used the pause properties in the definition of the rollout.

kubectl argo rollouts promote simple-rollout

- Rollback:

