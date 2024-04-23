
provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "eip_ec2" {
  count         = length(var.list)
  ami           = var.ami[count.index]
  instance_type = var.list[count.index]
  tags = {
    Name = var.vm_types[count.index]

  }
}
