resource "aws_subnet" "sn" {
  
  vpc_id = var.vpc_id
  cidr_block = var.address_space
  availability_zone = var.availability_zone
  
  tags = {
    Name = "${var.namespace}-sn"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "${var.namespace}-rt"
  }
}

resource "aws_route_table_association" "rt_asso" {
  subnet_id      = aws_subnet.sn.id
  route_table_id = aws_route_table.rt.id
}