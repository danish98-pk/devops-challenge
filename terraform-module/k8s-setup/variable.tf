variable "k8s_host" {
  type        = string
  description = "Kubernetes cluster endpoint"
}

variable "k8s_ca" {
  type        = string
  description = "Base64 encoded Kubernetes cluster CA certificate"
}

variable "k8s_token" {
  type        = string
  description = "Bearer token for Kubernetes authentication"
}

variable "namespace_app" {
  type        = string
  description = "namespace for the application"
}

variable "namespace_monitoring"{
  type        = string
  description = "namespace for the application"
}

variable "namespace_ingress"{
  type        = string
  description = "namespace for the ingress"
}