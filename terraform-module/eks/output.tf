####
####

output "eks_endpoint" {
  description = "cluster endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "eks_name" {
  description = "cluster name"
  value       = aws_eks_cluster.eks.name
}

output "cluster_certificate_authority" {
  description = "cluster CA cert"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}
