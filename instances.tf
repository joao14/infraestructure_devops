# PostgreSQL Instance
resource "aws_instance" "postgres_instance" {
  ami                    = "ami-0c55b159cbfafe1f0" # Amazon Linux 2023 AMI
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y postgresql-server
              postgresql-setup initdb
              systemctl enable postgresql
              systemctl start postgresql
              export $(aws secretsmanager get-secret-value --secret-id ${aws_secretsmanager_secret.db_credentials.name} --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]')
              sudo -u postgres psql -c "CREATE DATABASE baxtest;"
              sudo -u postgres psql -c "CREATE TABLE test_table (id SERIAL PRIMARY KEY, name TEXT, value TEXT);"
              EOF
}

# Nginx Instance
resource "aws_instance" "nginx_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnets[1].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
}
