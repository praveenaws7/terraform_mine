
provider "aws" {
  region = "us-east-1"
}


variable "security_groups" {
  description = "List of security group configurations."
  type = list(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  default = [
    {
      name        = "web_sg"
      description = "Security group for web servers"
      ingress     = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    {
      name        = "db_sg"
      description = "Security group for database servers"
      ingress     = [
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/16"]
        }
      ]
    },
    {
      name        = "my-custom"
      description = "Security group for web servers"
      ingress     = [
        {
          from_port   = 93
          to_port     = 93
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/32"]
        },
        {
          from_port   = 396
          to_port     = 396
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/21"]
        }
      ]
    }
  ]
}

    
resource "aws_security_group" "sg" {
  count       = length(var.security_groups)
  name        = var.security_groups[count.index].name
  description = var.security_groups[count.index].description

  dynamic "ingress" {
    for_each = var.security_groups[count.index].ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
