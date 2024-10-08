resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow inbound traffic from ECS tasks to RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "wordpress" {
  identifier           = "${var.project_name}-wordpress-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "${var.project_name}-wordpress-db"
  }
}
