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
  engine_version         = "8.0.35"              # Explicit version for stability
  instance_class         = "db.t3.micro"         # Free tier eligible
  allocated_storage      = 20                    # GB
  storage_type           = "gp2"
  db_name                = local.db_config.db_name
  username               = local.db_config.username
  password               = local.db_config.password
  port                   = local.db_config.port
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql.id]
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true                  # For development (set to false in prod)
  publicly_accessible    = false                 # Critical for security
  multi_az               = false                 # Set to true for production
  storage_encrypted      = true                  # Always encrypt at rest

  tags = {
    Name = "${local.env}-user-mgmt-db"
  }
}

# docker run --name local-mysql \
#   -e MYSQL_ROOT_PASSWORD=dev \
#   -e MYSQL_DATABASE=challenge \
#   -p 3306:3306 \
#   -d mysql:8

# instal mysql if using locally or to connect local machine to db
# #install mysql db core to run mysql commands

# connect mysql db 
# #mysql -h 127.0.0.1 -P 3306 -u root -p
# # password: dev

# create user
#  curl -X POST http://localhost:8080/user \
#   -H "Content-Type: application/json" \
#   -d '{"name": "danish"}'


# get method for user id
# # curl "http://localhost:8080/user?id=3"



# # install
# sudo dnf update -y
# sudo dnf install mariadb105


#test locally by grabbing the ing name and kill the ssl verification using -k arg , once tested , create acm and then create c name record for it and paste the ingress dns into it. for the reference , here is my live app working https://crewmeister.dkhalid.com

#curl -i -k -H "Host: crewmeister.dkhalid.com" https://k8s-crewmeis-crewmeis-a8d3f551a9-913327042.us-east-1.elb.amazonaws.com/user?id=1

#create usr command
#curl -X POST https://k8s-crewmeis-crewmeis-a8d3f551a9-913327042.us-east-1.elb.amazonaws.com/user \
#   -H "Host: crewmeister.dkhalid.com" \
#   -H "Content-Type: application/json" \
#   -d '{"name": "danish"}' \
#   -k
# Greetings from Crewmeister, danish!
