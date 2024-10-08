provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ecs" {
  source                     = "./modules/ecs"
  project_name               = var.project_name
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  alb_target_group_arn       = module.alb.target_group_arn
  alb_security_group_id      = module.alb.security_group_id
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn          = module.iam.ecs_task_role_arn
  secrets_arn                = module.secrets_manager.secret_arn
}

module "rds" {
  source                = "./modules/rds"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.ecs.ecs_tasks_security_group_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}

module "secrets_manager" {
  source      = "./modules/secrets-manager"
  project_name = var.project_name
  db_username  = var.db_username
  db_password  = var.db_password
  db_host      = module.rds.db_endpoint
  db_name      = var.db_name
}

module "iam" {
  source              = "./modules/iam"
  project_name        = var.project_name
  secrets_manager_arn = module.secrets_manager.secret_arn
}

module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  acm_certificate_arn = var.acm_certificate_arn
  route53_zone_id     = var.route53_zone_id
  domain_name         = var.domain_name
}


