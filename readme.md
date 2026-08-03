# awrf

homelab, it is made out of a dell r230, a openwrt one, and two lenovo t480s

* openwrt one: router for the lab L2
* dell r230: talos all-in-one k8s cluster, runs keycloak, slinky, warewulf, victoria
* t480s A: lustre
* t480s B: slurm login+compute node

Why called puppy? because k9s is a dog, and homelabs are small, so naturally x

### Init (talos)

1. install talos, get kubectl creds
https://docs.siderolabs.com/talos/v1.13/getting-started/getting-started#

### Init (ArgoCD)

1. kubectl create namespace argocd
2. kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
3. kubectl config set-context --current --namespace=argocd
4. argocd admin initial-password -n argocd


## todos
- [ ] get vm n vl to properly get logs n metrics from everything else
- [ ] 
