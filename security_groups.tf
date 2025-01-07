# ===========================================
# Security Group para PostgreSQL
# ===========================================
resource "aws_security_group" "postgres_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ===========================================
# Security Group para Nginx
# ===========================================
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ===========================================
# Security Group para ECS
# ===========================================
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group"
  description = "Permite acceso a ECS en el puerto 80."
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "Permitir acceso al puerto 80 para ECS."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}