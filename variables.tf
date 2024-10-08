variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "wordpress-ecs"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "db_name" {
  type    = string
  default = "wordpressdb"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}
