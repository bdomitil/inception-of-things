#! /bin/bash

app_file_name="/vagrant/dev/cd_test.yaml"
argo_ingress_file="/vagrant/scripts/argo_install.sh"
ingres_config_file="/vagrant/argo-traefic-ingress-config.yaml"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

if [ -f "$app_file_name" ]
then
    kubectl apply -n dev -f $app_file_name
fi

# while [ ! $(kubectl rollout -n argocd status deploy/argocd-server >2 /dev/null )  ] #wait while argocd-server deplot to start for forwarding its ports out
# do
#     echo 
# done
    nohup kubectl port-forward svc/traefik -n kube-system 443:443 --address=0.0.0.0 > /dev/null 2>&1 &
    nohup kubectl port-forward svc/traefik -n kube-system 80:80 --address=0.0.0.0 > /dev/null 2>&1 &
    nohup kubectl port-forward svc/argocd-server -n argocd 8080:443 --address=0.0.0.0 > /dev/null 2>&1 &