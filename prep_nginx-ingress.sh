#!/bin/sh
#
# Preperation for nginx-ingress
# See: https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/
#
# This script expects the ingress controller repo to be at ../kubernetes-ingress

# Configure RBAC
kubectl apply -f ../kubernetes-ingress/deployments/common/ns-and-sa.yaml
kubectl apply -f ../kubernetes-ingress/deployments/rbac/rbac.yaml
kubectl apply -f ../kubernetes-ingress/deployments/rbac/ap-rbac.yaml

# Create Common Resources
kubectl apply -f ../kubernetes-ingress/deployments/common/default-server-secret.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/nginx-config.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/ingress-class.yaml

# Create Custom Resources
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/k8s.nginx.org_transportservers.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/k8s.nginx.org_policies.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/k8s.nginx.org_globalconfigurations.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/global-configuration.yaml

# Resources for NGINX App Protect
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/appprotect.f5.com_aplogconfs.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/appprotect.f5.com_appolicies.yaml
kubectl apply -f ../kubernetes-ingress/deployments/common/crds/appprotect.f5.com_apusersigs.yaml