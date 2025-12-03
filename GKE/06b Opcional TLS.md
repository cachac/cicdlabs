# 08. Opcional TLS <!-- omit in TOC -->
>[cert-manager](https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/)

# Pre-req
- DNS records
> api-stage.<NAME>.kubelabs.tk


# 1. Install
```vim
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kgpo -n cert-manager
```

# Cluster Issuer
> [Issuer](./assets/apps-files/tls/clusterIssuer.yaml)

```vim
kubectl get clusterIssuer letsencrypt-prod

```
> type:  Ready
# secret
>[secret](./assets/apps-files/tls/secret.yaml)

# Kustomize Ingress
>[ingress](./assets/apps-files/tls/ing.yml)

## Kustomize ingress patch
>[patch](./assets/apps-files/tls/ing-patch.yaml)

# Check Cert
```vim
kubectl get certificate -A
kubectl describe certificate -A
>  The certificate has been successfully issued

kg CertificateRequest
> Certificate fetched from issuer successfully

kubectl describe challenge

kubectl logs -n cert-manager deploy/cert-manager -f
> Found status change for Certificate "ssl" condition "Ready": "False" -> "True";

k describe secret ssl
```

## Check GKE Ingress - Certificate details

## Check url fake cert (staging)
```vim
curl -v  --insecure https://api-stage.cachac.kubelabs2.tk/
```

> Server certificate, subject: CN=api-stage.cachac.kubelabs2.tk

> issuer: C=US; O=(STAGING) Let's Encrypt; CN=(STAGING) Artificial Apricot R3
