
#setup kubernetes provider
provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_ca)
  token                  = var.k8s_token
}

#we are going to create eks-admin for admin rights
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
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace_app
  }
}

resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = var.namespace_monitoring
  }
}

resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.namespace_ingress
  }
}

