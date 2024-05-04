resource "aws_vpc" "myvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.client_name}-VPC"
    Owner       = "Prakash"
    environment = local.env
  }
}
resource "aws_subnet" "mysub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${local.client_name}-Subnet"
    Owner       = "Prakash"
    environment = local.env
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name  = "${local.client_name}-IGW"
    Owner = "Prakash"
  }
}
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "${local.client_name}-RT"
  }
}
resource "aws_route_table_association" "myassoc" {
  route_table_id = aws_route_table.myrt.id
  subnet_id      = aws_subnet.mysub.id
}
resource "aws_security_group" "mysg" {
  vpc_id = aws_vpc.myvpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.client_name}-SG"
  }
}