# flux-control

## juice-docker-desktop


The following command will create a value that contains the json data
Set that value as a environment variable before running the kustomize build command.
```bash
kubectl create secret generic tunnel-credentials --from-file=credentials.json=/home/$USER/.cloudflared/<tunnel-id>.json -o yaml --dry-run=client
```

Remember to also run tenants env files.

```bash
kustomize build ./env/jonasandersen-no-tunnel | envsubst | kubectl apply -f -
```

```bash
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-control \
  --branch=main \
  --path=./clusters/$(kubectx -c)
```

## k3d setup

```bash
k3d cluster create juice --k3s-arg "--disable=traefik@server:0"
```
