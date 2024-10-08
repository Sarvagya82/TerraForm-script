resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "wordpress" {
  family                   = "${var.project_name}-wordpress"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "wordpress"
      image = "wordpress:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      secrets = [
        {
          name      = "WORDPRESS_DB_HOST"
          valueFrom = "${var.secrets_arn}:host::"
        },
        {
          name      = "WORDPRESS_DB_USER"
          valueFrom = "${var.secrets_arn}:username::"
        },
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = "${var.secrets_arn}:password::"
        },
        {
          name      = "WORDPRESS_DB_NAME"
          valueFrom = "${var.secrets_arn}:dbname::"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "wordpress" {
  name            = "${var.project_name}-wordpress-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  launch_type     = "FARGATE"
  desired_count   = var.service_desired_count

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "wordpress"
    container_port   = 80
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-ecs-tasks-sg"
  description = "Allow inbound traffic from ALB to ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
