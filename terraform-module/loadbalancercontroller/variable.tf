variable "policy_file" {
  description = "Path to the load balaner controller policy file"
  type        = string
}

#set the  eks_name
variable "eks_name" {
  description = "setup the eks name"
  type        = string
}

#set the  env
variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}


#set vpc id
variable "vpc_id" {
  description = "vpc id"
  type        = string
}