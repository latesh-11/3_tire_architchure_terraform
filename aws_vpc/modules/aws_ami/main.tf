data "aws_ami" "my_ami" {
  filter {
    name   = "name"
    values = [var.ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  most_recent = true
  owners = [var.ami_owner] # Canonical
}

