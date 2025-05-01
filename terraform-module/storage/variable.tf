variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "vpc_cidr_block" {
  description = "cidr  block for the vpc"
  type        = string
}

variable "vpc_id" {
  description = "id for the vpc"
  type        = string
}

variable "db_name" {
  description = " name of the database"
  type        = string
}


variable "engine" {
  type        = string
  description = "engine for the database"
}


#set the  engine version
variable "engine_version" {
  type        = string
  description = "engine version"
}

#set the  instance class
variable "instance_class" {
  description = "instance class use for mariadb"
  type        = string
}

#set the  allocated storage
variable "allocated_storage" {
  description = "allocated storage used for mariadb "
  type        = string
}

#set the  storage type
variable "storage_type" {
  description = "storage type for mariadb"
  type        = string
}

#set the db username
variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

#set the dp password
variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

#set the private subnet ids
variable "private_subnet_ids" {
  description = "List of Private Subnet ID"
  type        = list(string)
}


#set the db port
variable "db_port" {
  description = "Database port"
  type        = number
}

#set the db port
variable "db_from_port" {
  description = "Database from port sg"
  type        = number
}

#set the db port
variable "db_to_port" {
  description = "Database to port sg"
  type        = number
}

#set the parameter group name
variable "parameter_group_name" {
  description = "defauly mysql parameter group name"
  type        = string
}
