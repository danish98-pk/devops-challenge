data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}


# NAME: monitoring
# LAST DEPLOYED: Sun Apr 20 21:53:31 2025
# NAMESPACE: monitoring
# STATUS: deployed
# REVISION: 1
# NOTES:
# kube-prometheus-stack has been installed. Check its status by running:
#   kubectl --namespace monitoring get pods -l "release=monitoring"

# Get Grafana 'admin' user password by running:

#   kubectl --namespace monitoring get secrets monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

# Access Grafana local instance:

#   export POD_NAME=$(kubectl --namespace monitoring get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=monitoring" -oname)
#   kubectl --namespace monitoring port-forward $POD_NAME 3000

# Visit https://github.com/prometheus-operator/kube-prometheus for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.


##########
##########

# steps to install helm prometheus grafana stack

# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update

#helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace

#to test java app  getting scrapped
#http_server_requests_seconds_count 