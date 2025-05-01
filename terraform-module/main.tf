# AWS Networking resources --- ( VPC , IGW , NAT GATEWAY , ROUTETABLES , SUBNETS)
module "devops-challenge-network" {

  source = "./network"

  #set the vpc cidr block
  vpc_cidr_block = var.vpc_cidr_block

  #set the private subnet 1 cidr block
  private_zone_1_cidr_block = var.private_zone_1_cidr_block

  #set the private subnet 2 cidr block
  private_zone_2_cidr_block = var.private_zone_2_cidr_block

  #set the public subnet 1 cidr block
  public_zone_1_cidr_block = var.public_zone_1_cidr_block

  #set the public subnet 2 cidr block
  public_zone_2_cidr_block = var.public_zone_2_cidr_block

  #set the private routetable cidr block
  private_routetable_cidr_block = var.private_routetable_cidr_block

  #set the public routetable cidr block
  public_routetable_cidr_block = var.public_routetable_cidr_block

  #set the az 1
  availability_zone_1 = var.availability_zone_1

  #set the az 2
  availability_zone_2 = var.availability_zone_2

  #set the env for tag
  env = var.env

  #set the eks name
  eks_name = var.eks_name

}


# AWS ECR --- images will be uploaded here
module "devops-challenge-ecr" {

  source = "./ecr"

  ecr_name = var.ecr_name

  image_tag_mutability = var.image_tag_mutability

}

# AWS RDS --- User management data will be stored here
module "devops-challenge-rds" {

  source = "./rds"

  env = var.env

  vpc_id = module.devops-challenge-network.vpc_id

  vpc_cidr_block = var.vpc_cidr_block

  private_subnet_ids = [ module.devops-challenge-network.private_zone_1 
  , module.devops-challenge-network.private_zone_2 ]

  db_from_port = var.db_from_port

  db_to_port = var.db_to_port

  engine = var.engine

  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = var.storage_type

  db_name = var.db_name

  db_username = var.db_username

  db_password = var.db_password

  db_port = var.db_port

  parameter_group_name = var.parameter_group_name

}