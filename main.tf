# main.tf

# ====== Proveedor AWS ======
provider "aws" {
  region = "us-east-1" # Cambia a tu región preferida
}

# ====== VPC y Subnets ======
module "network" {
  source = "./vpc.tf"
}

module "subnets" {
  source = "./subnets.tf"
}

module "security_groups" {
  source = "./security_groups.tf"
}

# ====== Secrets Manager ======
module "secrets" {
  source = "./secrets.tf"
}

# ====== Instancias EC2 ======
module "instances" {
  source = "./instances.tf"
}

# ====== ECS Cluster y Servicio ======
module "ecs" {
  source = "./ecs.tf"
}

# ====== Salidas ======
output "postgres_instance_ip" {
  value = aws_instance.postgres_instance.public_ip
}

output "nginx_instance_ip" {
  value = aws_instance.nginx_instance.public_ip
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.privatebin_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.privatebin_service.name
}
