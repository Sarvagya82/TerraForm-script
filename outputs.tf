output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "wordpress_url" {
  value = "https://ecs.${var.domain_name}"
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}
