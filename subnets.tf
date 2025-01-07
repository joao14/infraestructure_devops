resource "aws_subnet" "public_subnets" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}

resource "aws_route_table_association" "subnet_association" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
