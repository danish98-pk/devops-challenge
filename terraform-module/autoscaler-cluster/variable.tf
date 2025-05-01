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


#set the  env
variable "region" {
  description = "set us-east-1"
  type        = string
}

