provider "aws" {
  region     = "us-east-1"
  access_key = "$ACCESSKEY"
  secret_key = "$SECRETKEY"
}


resource "aws_instance" "mfebucket" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.micro"
}

