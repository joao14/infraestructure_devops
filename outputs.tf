output "postgres_instance_ip" {
  value = aws_instance.postgres_instance.public_ip
}

output "nginx_instance_ip" {
  value = aws_instance.nginx_instance.public_ip
}
