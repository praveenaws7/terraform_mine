
provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "atp-apple" {
  bucket = "atp-apple1"

  tags = {
    Name        = "atp"
    Environment = "Dev"
  }
}

resource "aws_iam_user" "atp" {
  name = "atp-user"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "atp" {
  user = aws_iam_user.atp.name
}

data "aws_iam_policy_document" "atp-apple" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::atp-apple1"]
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = "atp-resource"
  user   = aws_iam_user.atp.name
  policy = data.aws_iam_policy_document.atp-apple.json
}