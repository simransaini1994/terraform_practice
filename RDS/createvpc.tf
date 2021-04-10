resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "test-public-1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone ="us-east-2a"
  tags = {
    Name = "test-public-1"
  }
}

resource "aws_subnet" "test-public-2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone ="us-east-2b"
  tags = {
    Name = "test-public-2"
  }
}

resource "aws_subnet" "test-private-1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.1.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone ="us-east-2a"
  tags = {
    Name = "test-private-1"
  }
}

resource "aws_subnet" "test-private-2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.1.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone ="us-east-2b"
  tags = {
    Name = "test-public-2"
  }
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-gw"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }


  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.test-public-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.test-public-2.id
  route_table_id = aws_route_table.public-route-table.id
}
