output "db_endpoint" {
  value = aws_db_instance.wordpress.endpoint
}

output "db_name" {
  value = aws_db_instance.wordpress.db_name
}

output "db_username" {
  value = aws_db_instance.wordpress.username
}
