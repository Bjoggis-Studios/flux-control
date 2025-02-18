# flux-control

## juice-docker-desktop

Tip: You can run the setup script to automatically setup the cluster with correct secrets and a bootstrapped flux.
```bash
chmod +x setup

./setup
```

To recreate a cluster you will need to delete it first with the command
```bash
k3d cluster delete juice
```

### The commands below is ran in the setup function, but kept here for easy access.

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
kustomize build ./env/jonasandersen-no | envsubst | kubectl apply -f -
```

## Flux

### Install
```bash
curl -s https://fluxcd.io/install.sh | sudo bash
```
To configure your shell to load flux bash completions add to your profile:
```bash
. <(flux completion bash)
```

```bash
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-control \
  --branch=main \
  --path=./clusters/$(kubectx -c)
```

Optional flux command that supports image updating
```bash
 flux bootstrap github \
   --owner=Bjoggis-Studios \   
   --repository=flux-control \
   --branch=main \
   --path=./clusters/$(kubectx -c) \
   --components-extra image-reflector-controller,image-automation-controller \
   --read-write-key
```


## k3d setup

```bash
k3d cluster create juice --k3s-arg "--disable=traefik@server:0"
```


## k3sup setup

Setup a cluster with k3sup

```bash
export CONTROL_NODE_IP=<ip>
k3sup install --ip $CONTROL_NODE_IP --user gollien --k3s-extra-args '--disable traefik' --merge --local-path ~/.kube/config --context cluster00 --ssh-key pi-cluster
```

If running from control node
```bash
k3sup install --ip 172.19.181.254 --user gollien --ssh-key /home/gollien/.ssh/id_ed25519 --k3s-extra-args '--disable traefik' --context cluster00  
```


# Cloudflare tunnel
```bash
cloudflared tunnel create <NAME>
```

Take credential file from cloudflare and transform it to a 

Example to create secret from credentials file.

Put the value of the single data entry in 1Password and depend on it in .envrc
```bash
kubectl create secret generic database-credentials --dry-run=client --output=yaml --from-file .cloudflared/83a81522-daed-4722-838e-e261fb258769.json
```
