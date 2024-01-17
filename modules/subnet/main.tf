resource "aws_subnet" "sn" {

  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.cidr_block, 4, 0)

  tags = {
    Name = "${var.migratorydata_prefix}-sn"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "${var.migratorydata_prefix}-rt"
  }
}

resource "aws_route_table_association" "rt_asso" {
  subnet_id      = aws_subnet.sn.id
  route_table_id = aws_route_table.rt.id
}