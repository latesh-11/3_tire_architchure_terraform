resource "aws_nat_gateway" "natGW" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id

  tags = var.tags

}

