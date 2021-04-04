resource "aws_eip" "test-nat" {
  vpc = true
}

resource "aws_nat_gateway" "test-nat-gw" {
  allocation_id = aws_eip.test-nat.id
  subnet_id     = aws_subnet.test-public-1.id
  depends_on = [aws_internet_gateway.test-gw]
  tags = {
    Name = "test-nat-gw"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test-nat-gw.id
  }
   tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.test-private-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.test-private-2.id
  route_table_id = aws_route_table.private-route-table.id
}
