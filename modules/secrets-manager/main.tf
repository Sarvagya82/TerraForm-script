resource "aws_secretsmanager_secret" "wordpress_db" {
  name = "${var.project_name}-wordpress-db-secrets"
}

resource "aws_secretsmanager_secret_version" "wordpress_db" {
  secret_id = aws_secretsmanager_secret.wordpress_db.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    dbname   = var.db_name
  })
}
