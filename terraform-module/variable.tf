
################################
################################
#         network variables
################################
################################
variable "vpc_cidr_block" {
  description = ""
  type        = string
}

variable "env" {
  description = "environemnt"
  type        = string
}


variable "private_zone_1_cidr_block" {
  description = "private zone 1 cidr block"
  type        = string
}


variable "private_zone_2_cidr_block" {
  description = "private zone 1 cidr block"
  type        = string
}


variable "public_zone_1_cidr_block" {
  description = "public zone 1 cidr block"
  type        = string
}



variable "public_zone_2_cidr_block" {
  description = "public zone 1 cidr block"
  type        = string
}

variable "private_routetable_cidr_block" {
  description = "private routetable cidr block {0.0.0.0/0}"
  type        = string
}

variable "public_routetable_cidr_block" {
  description = "public routetable cidr block {0.0.0.0/0}"
  type        = string
}

variable "availability_zone_1" {
  description = "setup the availaibility zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "setup the availaibility zone 2"
  type        = string
}


#########################
#########################
# ecr variables
#########################
#########################

variable "ecr_name" {
  description = "set ecr repo name"
  type        = string
}


variable "image_tag_mutability" {
  description = "set image tag mutability"
  type        = string
}

###########################
###########################

#        eks variables

###########################
###########################
variable "eks_name" {
  description = "setup the eks name through the module"
  type        = string
}



variable "eks_version" {
  description = "setup the eks version"
  type        = string
}


variable "desired_size" {
  description = "setup the eks version"
  type        = number
}

variable "max_size" {
  description = "setup max size"
  type        = number
}


variable "min_size" {
  description = "setup min size"
  type        = number
}

#set
variable "max_unavailable" {
  description = "max_unavailable"
  type        = number
}


##########################
##########################

#  RDS variables
###########################
###########################

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


variable "region" {
  description = "region -- us-east-1"
  type        = string
}