# DB Subnet Group (Required for RDS in VPC)
resource "aws_db_subnet_group" "mysql" {
  name       = "${local.env}-mysql-subnet-group"
  subnet_ids = [aws_subnet.private_zone1.id, aws_subnet.private_zone2.id]
  tags = {
    Name = "${local.env}-mysql-subnet-group"
  }
}

# Security Group
resource "aws_security_group" "mysql" {
  name        = "${local.env}-mysql-sg"
  description = "Allow MySQL from EKS pods"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MySQL from EKS private subnets"
    from_port   = local.db_config.port
    to_port     = local.db_config.port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-mysql-sg"
  }
}

# MySQL RDS Instance
resource "aws_db_instance" "mysql" {
  identifier             = "${local.env}-user-mgmt-db"
  engine                 = "mysql"
  engine_version         = "8.0.35" 
  instance_class         = "db.t3.micro" 
  allocated_storage      = 20 
  storage_type           = "gp2"
  db_name                = local.db_config.db_name
  username               = local.db_config.username
  password               = local.db_config.password
  port                   = local.db_config.port
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql.id]
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true 
  publicly_accessible    = false
  multi_az               = false
  storage_encrypted      = true     

  tags = {
    Name = "${local.env}-user-mgmt-db"
  }
}

