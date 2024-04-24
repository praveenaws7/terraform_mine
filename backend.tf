terraform {
  backend "s3" {
    bucket = "bucketrandoneforpre"
    key    = "./terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = "us-east-1"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucketrandoneforpre"
  
}
