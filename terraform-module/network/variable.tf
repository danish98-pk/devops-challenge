variable "vpc_cidr_block" {
  description = "cidr  block for the vpc"
  type        = string
}

variable "private_zone_1_cidr_block" {
  description = "cidr block for the prive zone or subnet 1"
  type        = string
}

variable "private_zone_2_cidr_block" {
  description = "cidr block for the prive zone or subnet 2"
  type        = string
}

variable "public_zone_1_cidr_block" {
  description = "cidr block for the public zone or subnet 1"
  type        = string
}

variable "public_zone_2_cidr_block" {
  description = "cidr block for the public zone or subnet 2"
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


variable "public_routetable_cidr_block" {
  description = " 0.0.0.0/0 cidr block will be placed here"
  type        = string
}

variable "private_routetable_cidr_block" {
  description = " 0.0.0.0/0 cidr block will be placed here"
  type        = string
}

variable "eks_name" {
  description = "setup eks name"
  type        = string
}

variable "env" {
  description = "setup env name"
  type        = string
}