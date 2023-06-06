resource "aws_instance" "web" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups = [var.security_group_id]
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  tags = var.tags
}


