resource "aws_vpc" "vpc" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    Name = "${var.namespace}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.namespace}-gw"
  }
}
