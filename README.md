# docker-desktop_metallb_nginx-ingress
K8s setup with docker-desktop, MetalLB and NGINX+ as ingress controller.

# Introduction
This is a companion repository to the official NGINX Inc. kubernetes-ingress repository.

[MetalLB](https://metallb.universe.tf/) is used to deploy the official examples on top of Docker Desktop (with Kubernetes enabled). 

## Setup Metallb

```
cleygraf@mbp15ret  (⎈ |docker-desktop:default) [~] $ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
namespace/metallb-system created
cleygraf@mbp15ret  (⎈ |docker-desktop:default) [~] $ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
podsecuritypolicy.policy/controller created
podsecuritypolicy.policy/speaker created
serviceaccount/controller created
serviceaccount/speaker created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
role.rbac.authorization.k8s.io/config-watcher created
role.rbac.authorization.k8s.io/pod-lister created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/config-watcher created
rolebinding.rbac.authorization.k8s.io/pod-lister created
daemonset.apps/speaker created
deployment.apps/controller created
cleygraf@mbp15ret  (⎈ |docker-desktop:default) [~] $ kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
secret/memberlist created
cleygraf@mbp15ret  (⎈ |docker-desktop:default) [~] $ kc get pods -n metallb-system
NAME                          READY   STATUS    RESTARTS   AGE
controller-65db86ddc6-xhp6x   1/1     Running   0          14m
speaker-np8fs                 1/1     Running   0          14m
cleygraf@mbp15ret  (⎈ |docker-desktop:default) [~] $

cleygraf@mbp15ret {main?} (⎈ |docker-desktop:default) [docker-desktop_metallb_nginx-ingress] $ kc apply -f ./l2-dockerce.yml
configmap/config created
cleygraf@mbp15ret {main?} (⎈ |docker-desktop:default) [docker-desktop_metallb_nginx-ingress] $
```

See https://medium.com/@JockDaRock/kubernetes-metal-lb-for-docker-for-mac-windows-in-10-minutes-23e22f54d1c8

## Configure nginx-ingress
Use nginx-plus-ap-ingress.yaml to deploy nginx-ingress. The NGINX+ dashboard is enabled [https://dashboard.example.com/dashboard.html](https://dashboard.example.com/dashboard.html):

Preview policies are enabled too.

## examples/appprotect
https://github.com/nginxinc/kubernetes-ingress/tree/master/examples/appprotect

### URLs
https://cafe.example.com:443/coffee
https://cafe.example.com:443/tea

Blocked by NGINX AppProtect (WAF)
https://cafe.example.com:443/coffee/?v=<script>

### Touble shooting

```
 curl --resolve cafe.example.com:443:127.0.0.240 https://cafe.example.com:443/coffee --insecure
 kubectl exec -it syslog-76c65fd9b9-xqvhc -- cat /var/log/messages
 kubectl logs nginx-ingress-547484f465-c82wf -n nginx-ingress
 kubectl exec nginx-ingress-547484f465-c82wf -n nginx-ingress -- nginx -T
```

## examples-of-custom-resources/oidc
https://github.com/nginxinc/kubernetes-ingress/tree/master/examples-of-custom-resources/oidc

### Attention
In order to use the OICD policy with ingress-controller 1.10, *preview policies* need to be enabled in the nginx-ingress deployment. Please see the included `nginx-plus-ap-ingress.yaml` for details.

###
To configure Keycloak, follow steps described in `keycloak_setup.md`. If the variable `SECRET`is `null` please login into [keycloak ui](https://keycloak.example.com), go to "Clients", select "nginx-plus" and go to the tab "Credentials". Copy the value of the field "Secret" and assign it to the variable `SECRET` in the shell:

```
cleygraf@razor17pro10th {tags/v1.10.1!}  [oidc] $ SECRET="bc75fa28-c8a2-431b-84db-ea9a4acd0627"
```

Follow the steps in `README.md`, but skip "Step 4".


### URLs
Keycloak:
https://keycloak.example.com

Webapp:
https://webapp.example.com