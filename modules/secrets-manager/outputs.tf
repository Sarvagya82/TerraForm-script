output "secret_arn" {
  value = aws_secretsmanager_secret.wordpress_db.arn
}
