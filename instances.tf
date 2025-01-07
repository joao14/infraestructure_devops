# ===========================================
# Instancia EC2 para PostgreSQL
# ===========================================
resource "aws_instance" "postgres_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
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
              EOF

  tags = {
    Name = "PostgreSQL-Instance"
  }
}

# ===========================================
# Instancia EC2 para Nginx
# ===========================================
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

  tags = {
    Name = "Nginx-Instance"
  }
}
