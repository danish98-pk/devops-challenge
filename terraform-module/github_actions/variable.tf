variable "repo_name" {
  description = "GitHub repository in format owner/repo"
  type        = string
}

variable "repo_branch" {
  description = "Branch to allow OIDC authentication for"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
}

variable "policy_arn" {
  description = "IAM policy ARN to attach to the GitHub Actions role"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "eks_cluster_name" {
  description = "EKS cluster name for access entry"
  type        = string
}

variable "kubernetes_groups" {
  description = "List of Kubernetes groups for EKS access"
  type        = list(string)
  default     = ["my-admin"]
}

variable "env" {
  description = "envirorment"
  type        = string
}

variable "eks_name" {
  description = "environment"
  type        = string
}
