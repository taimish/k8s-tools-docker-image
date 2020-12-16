# k8s-tools-docker-image
A Dockerfile with a docker image for the k8s tools
  
Example of shell commands for cluster configuration for kubecrl usage:  
kubectl config set-cluster my_cluster_name --server=https://my_cluster_url:6443 --certificate-authority=/path_to_my_cluster_certificate  
kubectl config set-credentials my_cluster_user --token=my_cluster_user_t0ken  
kubectl config set-context my_cluster_name --cluster=my_cluster_name --user=my_cluster_user  
kubectl config set-context my_cluster_name --namespace=my_k8s_namespace  
kubectl config use-context my_cluster_name  
