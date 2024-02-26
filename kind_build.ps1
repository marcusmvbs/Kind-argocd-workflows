# Common Variables
$imageName      = "kind_docker_image"
$containerName  = "kind_container"
$network_type   = "--network=host"
$socket_volume  = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec  = "ansible-playbook -i Ansible/inventory.ini Ansible/playbook.yaml"
$argocd_install = "kubectl apply -n argocd-ns -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
$apply_app      = "kubectl apply -f application.yaml"
$kyverno_config = "kubectl apply -f Kind/charts/dev/kyverno/templates/clusterpolicy.yaml"
$nginx_config   = "kubectl apply -f Kind/charts/dev/nginx/templates/deployment.yaml"

# Docker Variables
$DockerBuildCmd = "docker build -t $imageName ."
$DockerRunCmd   = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"

# Ansible Variables
$AnsiblePlaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

# ArgoCD variables
$Apply_ArgoCD  = "docker exec -it $containerName sh -c '$argocd_install'"
$Apply_ArgoApp = "docker exec -it $containerName sh -c '$apply_app'"

# Kubernetes Environment Variables
$Apply_Kyverno = "docker exec -it $containerName sh -c '$kyverno_config'"
$Apply_Nginx   = "docker exec -it $containerName sh -c '$nginx_config'"

## RUN commands ##

# Build Docker container
Invoke-Expression -Command $DockerBuildCmd
# Run Docker container
Invoke-Expression -Command $DockerRunCmd

# Execute Ansible tasks
Invoke-Expression -Command $AnsiblePlaybook
Start-Sleep -Seconds 10

# Argocd install and manifest application ##
Invoke-Expression -Command $Apply_ArgoCD
Invoke-Expression -Command $Apply_ArgoApp

# # Apply Kubernetes config
# Start-Sleep -Seconds 120
# Invoke-Expression -Command $Apply_Kyverno

# # Create nginx pod using Kyverno policy of cpu and memory defined
# Invoke-Expression -Command $Apply_Nginx