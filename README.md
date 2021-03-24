# docker-desktop_metallb_nginx-ingress
K8s setup with docker-desktop, MetalLB and NGINX+ as ingress controller.

See https://medium.com/@JockDaRock/kubernetes-metal-lb-for-docker-for-mac-windows-in-10-minutes-23e22f54d1c8

### examples/appprotect
https://cafe.example.com:443/coffee

```
 curl --resolve cafe.example.com:443:127.0.0.240 https://cafe.example.com:443/coffee --insecure
 kubectl exec -it syslog-76c65fd9b9-xqvhc -- cat /var/log/messages
 kubectl logs nginx-ingress-547484f465-c82wf -n nginx-ingress
 kubectl exec nginx-ingress-547484f465-c82wf -n nginx-ingress -- nginx -T
```
