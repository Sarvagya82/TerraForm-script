output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  value = aws_ecs_service.wordpress.name
}

output "ecs_tasks_security_group_id" {
  value = aws_security_group.ecs_tasks.id
}
