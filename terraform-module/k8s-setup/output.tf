output "namespaces" {
  value = [
    kubernetes_namespace.app.metadata[0].name,
    kubernetes_namespace.prometheus.metadata[0].name,
    kubernetes_namespace.ingress.metadata[0].name,
  ]
}
