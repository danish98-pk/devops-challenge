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


#set the  engine version
variable "eks_version" {
  type        = string
  description = "engine version"
}


#set the private subnet ids
variable "private_subnet_ids" {
  description = "List of Private Subnet ID"
  type        = list(string)
}