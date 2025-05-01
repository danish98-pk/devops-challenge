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


#set the desired size
variable "desired_size" {
  description = "desired size"
  type        = number
}

variable "max_size" {
  description = "max_size"
  type        = number
}

variable "min_size" {
  description = "minimum size"
  type        = number
}

variable "max_unavailable" {
  description = "max_unavailable"
  type        = number
}