variable "vpc_cidr_block" {
  default = "10.3.0.0/18"
}

variable "subnet_cidrs" {
  default = ["10.3.5.0/24", "10.3.7.0/24", "10.3.9.0/24"]
}

variable "ec2_instance_type" {
  default = "t3.micro"
}

variable "db_username" {}
variable "db_password" {}
