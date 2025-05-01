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

  source = "./storage"

  env = var.env

  vpc_id = module.devops-challenge-network.vpc_id

  vpc_cidr_block = var.vpc_cidr_block

  private_subnet_ids = [module.devops-challenge-network.private_zone_1
  , module.devops-challenge-network.private_zone_2]

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


### AWS EKS Cluster Module
module "devops-challenge-eks-cluster" {

  source = "./eks"

  env = var.env

  eks_name = var.eks_name

  eks_version = var.eks_version

  private_subnet_ids = [module.devops-challenge-network.private_zone_1
  , module.devops-challenge-network.private_zone_2]

}


### AWS EKS Node Group
module "devops-challenge-eks-node" {

  source = "./node-group"

  env = var.env

  eks_name = var.eks_name

  eks_version = var.eks_version

  private_subnet_ids = [module.devops-challenge-network.private_zone_1
  , module.devops-challenge-network.private_zone_2]

  desired_size = var.desired_size

  max_size = var.max_size

  min_size = var.min_size
  
  max_unavailable = var.max_unavailable

}



data "aws_eks_cluster_auth" "eks" {
  name = module.devops-challenge-eks-cluster.eks_name
}


#connecting kubernetes and deploy namespaces on the fly
module "k8s_setup" {
  source = "./k8s-setup"

  k8s_host  = module.devops-challenge-eks-cluster.eks_endpoint
  k8s_ca    = module.devops-challenge-eks-cluster.cluster_certificate_authority
  k8s_token = data.aws_eks_cluster_auth.eks.token

  namespace_app        = "crewmeister"
  namespace_monitoring = "monitoring"
  namespace_ingress    = "ingress"
}




### AWS  IAM
module "devops-challenge-iam" {

  source = "./iam"

  env = var.env

  eks_name = var.eks_name
}


provider "helm" {
  kubernetes {
    host                   = module.devops-challenge-eks-cluster.eks_endpoint
    cluster_ca_certificate = base64decode(module.devops-challenge-eks-cluster.cluster_certificate_authority)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}



module "metrics_server" {
  source      = "./helm-metrics-server"
  values_file = "${path.module}/values/metrics-server.yaml"

  providers = {
    helm = helm
  }
}


### AWS  POD Identity
module "devops-challenge-pod-identity-addon" {

  source = "./pod-identity"

  env = var.env

  eks_name = var.eks_name
}


## AutoScaler HelmChart
module "devops-challenge-autoscaler" {

  source = "./autoscaler-cluster"

  env = var.env

  eks_name = var.eks_name
  
  region = var.region

    providers = {
    helm = helm
  }
}


## AWS LOAD BALANCER CONTROLLER HELM CHART
module "devops-challenge-loadbalancercontroller" {

  source = "./loadbalancercontroller"

  env = var.env

  eks_name = var.eks_name

  vpc_id = module.devops-challenge-network.vpc_id

  policy_file = "${path.module}/AWSLoadBalancerController.json"

    providers = {
    helm = helm
  }
}








