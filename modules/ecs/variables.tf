variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_target_group_arn" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "secrets_arn" {
  type = string
}

variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}

variable "service_desired_count" {
  type    = number
  default = 2
}
