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

or reset via
`talosctl reset --nodes 192.168.2.240 --endpoints 192.168.2.240 --graceful=false --reboot --wipe-mode all --talosconfig talosconfig`


- `talosctl get disks --insecure --nodes $IP`
- `talosctl gen config puppy https://192.168.2.240:6443 --install-disk /dev/sdb --config-patch @patch.yaml`
- `talosctl apply-config --insecure --nodes 192.168.2.240 --file controlplane.yaml`
- `talosctl --talosconfig=./talosconfig config endpoints 192.168.2.240`
- `talosctl bootstrap --nodes 192.168.2.240 --talosconfig=./talosconfig`
- `talosctl kubeconfig --nodes 192.168.2.240 --talosconfig=./talosconfig`

```
helm repo add cilium https://helm.cilium.io/
helm repo update

helm template \
    cilium \
    cilium/cilium \
    --version 1.18.0 \
    --namespace kube-system \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set operator.replicas=1 \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445 > cilium.yaml

kubectl apply -f cilium.yaml
```

### Init (ArgoCD)

```
kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl config set-context --current --namespace=argocd
kubectl apply -n argocd -f apps.yaml
```
- `argocd admin initial-password -n argocd`
- `kubectl port-forward svc/argocd-server -n argocd 8080:443`


## todos
- [ ] get vm n vl to properly get logs n metrics from everything else
