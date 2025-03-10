resource "aws_db_subnet_group" "rds" {
  name = "${var.project_name}-rds-subnet-group"
  description = "Subnet group for RDS"

  subnet_ids = [
    aws_subnet.private_rds-a.id,
    aws_subnet.private-rds-b.id
  ]

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage = 20
  engine = "postgres"
  engine_version = "14.5"
  instance_class = "db.t2.micro"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]
  multi_az = false
  publicly_accessible = false

  tags = {
    Name = "${var.project_name}-postgres"
  }
}

resource "aws_security_group" "db_sg" {
  name = "${var.project_name}-db-sg"
  description = "Allow traffic from backend to RDS"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    protocol  = "tcp"
    to_port   = 5432
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-db-sg"
  }
}