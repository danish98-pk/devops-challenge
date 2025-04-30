resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.10.1"

  values = [file("${path.module}/values/nginx-ingress.yaml")]

  depends_on = [helm_release.aws_lbc]
}



#note
#  Important: external_nginx Will Fail Without aws-lbc
# If you try to deploy NGINX with a LoadBalancer service type and annotations before aws-lbc is active, Kubernetes will:

# Mark the service as <pending>

# The Terraform apply might time out

# Helm will show the release as failed

# That matches the "context deadline exceeded" error you saw earlier.

# ✅ Your Current Setup Looks Correct
# You install aws-lbc with proper IAM role and pod identity.

# You attach IAM permissions via a custom policy.

# You deploy NGINX only after aws-lbc is running.

# This is the right approach.