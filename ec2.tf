resource "aws_s3_bucket" "renamed_new" {
  bucket = "jum08th15"  # Replace with your existing bucket name
  acl    = "private"

  versioning {
    enabled = true
  }
    tags = {
    Name = "My Production Bucket"
    Environment = "Praveen"
    Kumar = "Bhavikatti"
  }

  # Other bucket configuration...
}
