# DB Subnet Group (Required for RDS in VPC)
resource "aws_db_subnet_group" "mysql" {
  name       = "${var.env}-mysql-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "${var.env}-mysql-subnet-group"
  }
}

# Security Group
resource "aws_security_group" "mysql" {
  name        = "${var.env}-mysql-sg"
  description = "Allow MySQL from EKS pods"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL from EKS private subnets"
    from_port   = var.db_from_port
    to_port     = var.db_to_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-mysql-sg"
  }
}

# MySQL RDS Instance
resource "aws_db_instance" "mysql" {
  identifier             = "${var.env}-user-mgmt-db"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql.id]
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  storage_encrypted      = true

  tags = {
    Name = "${var.env}-user-mgmt-db"
  }
}