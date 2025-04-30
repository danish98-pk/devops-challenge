provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

#create a group for the IAM role that we are going to assume
resource "kubernetes_cluster_role_binding" "my_admin_binding" {
  metadata {
    name = "my-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "Group"
    name      = "my-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}

#create a namespace where we are going to deploy our app
resource "kubernetes_namespace" "app" {
  metadata {
    name = "crewmeister"
  }
}


#create a namespace where we are going to deploy our monitoring system
resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "monitoring"
  }
}

#create a namespace where we are going to deploy our nginx
resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}
