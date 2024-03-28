# Common Variables
$containerName = "kind_container"

# Docker exec bash
$KindExecCommand = "docker exec -it $containerName /bin/bash"

# Get pods
$kubectl_pods = "kubectl get pods -A"
$Get_Pods     = "docker exec -it $containerName sh -c '$kubectl_pods'"
Invoke-Expression -Command $Get_Pods

## Run Commands ##
Write-Output "`nDocker container env, welcome aboard! =)`n"

$Logs_Exporter = "docker exec -it $containerName sh -c 'kubectl logs pod/ -n monitoring'"
# Invoke-Expression -Command $Logs_Exporter

# Execute Kind Cluster
Invoke-Expression -Command $KindExecCommand

# $Rollout = "docker exec -it $containerName sh -c 'kubectl argo rollouts get rollout nginx-deploy -n webserver --watch'"
# Invoke-Expression -Command $Rollout


# Control plane upgrade
# docker exec -it kind-control-plane /bin/bash
# ssh kind-control-plane
# apt-mark unhold kubelet kubectl
# apt-get update && apt-get install -y kubelet='1.27.0-*' kubectl='1.27.0-*' && \
# apt-mark hold kubelet kubectl
