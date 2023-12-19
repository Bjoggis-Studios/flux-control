# flux-control

## juice-docker-desktop

Tip: You can run the setup script to automatically setup the cluster with correct secrets and a bootstrapped flux.
```bash
chmod +x setup

./setup
```
### The commands below is ranin the setup function, but kept here for easy access.

The following command will create a value that contains the json data
Set that value as a environment variable before running the kustomize build command.
```bash
kubectl create secret generic tunnel-credentials --from-file=credentials.json=/home/$USER/.cloudflared/<tunnel-id>.json -o yaml --dry-run=client
```

```bash
kubectl create secret generic config-server-credentials -n jonasandersen-no --from-literal=username=$SPRING_CLOUD_CONFIG_USERNAME --from-literal=password=$SPRING_CLOUD_CONFIG_PASSWORD
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
