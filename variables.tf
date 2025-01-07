# ===========================================
# Variables de Red oaara ell proyecto
# ===========================================
variable "vpc_cidr_block" {
  description = "Rango CIDR para la VPC principal."
  type        = string
  default     = "10.3.0.0/18"
}

variable "subnet_cidrs" {
  description = "Lista de rangos CIDR para las subredes."
  type        = list(string)
  default     = ["10.3.5.0/24", "10.3.7.0/24", "10.3.9.0/24"]
}

# ===========================================
# Variables de EC2 para el proyecto
# ===========================================
variable "ec2_instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
  default     = "t3.micro"
}

# ===========================================
# Base de Datos (Secrets Manager)
# ===========================================
variable "db_username" {
  description = "Nombre de usuario para la base de datos PostgreSQL."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Contraseña para la base de datos PostgreSQL."
  type        = string
  sensitive   = true
}

# ===========================================
# Variables de ECS
# ===========================================
variable "ecs_cluster_name" {
  description = "Nombre del clúster ECS."
  type        = string
  default     = "privatebin-cluster"
}

variable "ecs_service_name" {
  description = "Nombre del servicio ECS."
  type        = string
  default     = "privatebin-service"
}

# ===========================================
# Variables de Seguridad
# ===========================================
variable "allowed_cidr_block" {
  description = "Rango de IP permitido para el acceso a las instancias."
  type        = string
  default     = "0.0.0.0/0"
}

# ===========================================
# Variables de Región y Zonas
# ===========================================
variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para las subredes."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
