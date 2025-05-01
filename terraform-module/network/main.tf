# Create a VPC
resource "aws_vpc" "main" {

  # CIDR block for the VPC
  cidr_block = var.vpc_cidr_block

  # Enable DNS support in the VPC
  enable_dns_support = true

  # Enable DNS support in the VPC
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-main"
  }
}

# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "igw" {

  # Attach to the main VPC
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# Create the first private subnet in zone 1
resource "aws_subnet" "private_zone1" {

  # VPC association
  vpc_id = aws_vpc.main.id

  # CIDR block for the private zone 1 
  cidr_block = var.private_zone_1_cidr_block

  # az where the subnet will reside 
  availability_zone = var.availability_zone_1

  tags = {
    "Name"                                  = "${var.env}-private-zone1"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "shared"
  }
}

# Create the second private subnet in zone 2
resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_zone_2_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    "Name"                                  = "${var.env}-private-zone2"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "shared"
  }
}

# Create the first public subnet in zone 1
resource "aws_subnet" "public_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_zone_1_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    "Name"                                  = "${var.env}-public-zone1"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}"= "shared"
  }
}

# Create the second public subnet in zone 2
resource "aws_subnet" "public_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_zone_2_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    "Name"                                  = "${var.env}-public-zone2"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "shared"
  }
}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.env}-nat"
  }
}

# Create a NAT Gateway in the first public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "${var.env}-nat"
  }

  #making sure internet gateways build first before nat
  depends_on = [aws_internet_gateway.igw]
}

# Create a route table for public subnets to route traffic via NAT
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.private_routetable_cidr_block
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.env}-private-route"
  }
}

# Create a route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_routetable_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-route"
  }
}


# Associate the private route table with private_zone1
resource "aws_route_table_association" "private_zone1" {
  subnet_id      = aws_subnet.private_zone1.id
  route_table_id = aws_route_table.private.id
}

# Associate the private route table with private_zone2
resource "aws_route_table_association" "private_zone2" {
  subnet_id      = aws_subnet.private_zone2.id
  route_table_id = aws_route_table.private.id
}

# Associate the public route table with public_zone1
resource "aws_route_table_association" "public_zone1" {
  subnet_id      = aws_subnet.public_zone1.id
  route_table_id = aws_route_table.public.id
}

# Associate the public route table with public_zone2
resource "aws_route_table_association" "public_zone2" {
  subnet_id      = aws_subnet.public_zone2.id
  route_table_id = aws_route_table.public.id
}
