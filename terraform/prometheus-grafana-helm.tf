# # resource "helm_release" "kube-prometheus-stack" {
# #   name = "kube-prometheus-stack"

# #   repository = "https://prometheus-community.github.io/helm-charts"
# #   chart      = "kube-prometheus-stack"
# #   namespace  = "monitoring"
# #   create_namespace = true
# #   version    = "56.6.0"  
# #   depends_on = [aws_eks_node_group.general]
# # }


# # ### the above helms deploys following pods
# # # Pod Name	Main Job
# # # alertmanager	Send notifications when alerts fire
# # # grafana	Beautiful dashboards
# # # kube-state-metrics	Exposes Kubernetes object status
# # # operator	Auto-manages Prometheus, Alertmanager configs
# # # node-exporter	Node hardware metrics
# # # prometheus	Collects, stores, and evaluates all metrics


# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     name = "monitoring"
#   }
# }

# resource "helm_release" "kube-prometheus-stack" {
#   name             = "kube-prometheus-stack"
#   repository       = "https://prometheus-community.github.io/helm-charts"
#   chart            = "kube-prometheus-stack"
#   namespace        = kubernetes_namespace.monitoring.id
#   version          = "56.6.0"

#   depends_on = [
#     kubernetes_namespace.monitoring
#   ]

#   wait    = true
#   atomic  = true
#   timeout = 2000

#   set {
#     name  = "podSecurityPolicy.enabled"
#     value = "true"
#   }

#   set {
#     name  = "server.persistentVolume.enabled"
#     value = "false"
#   }

#   set {
#     name  = "server.resources"
#     value = yamlencode({
#       limits = {
#         cpu    = "200m"
#         memory = "50Mi"
#       }
#       requests = {
#         cpu    = "100m"
#         memory = "30Mi"
#       }
#     })
#   }

#   set {
#     name = "prometheusOperator.createCustomResource"
#     value = "true"
#   }
# }
