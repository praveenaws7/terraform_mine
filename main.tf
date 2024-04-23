provider "aws" {
  region  = "us-east-1"

}

resource "aws_instance" "nginx-server" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.small"
  count = 10
}

resource "aws_iam_user" "iam" {
  name = "apple"
  path = "/system/"

  tags = {
    tag-key = "atp-apple"
  }
}

resource "aws_iam_access_key" "atp-key" {
  user = aws_iam_user.iam.name
}

data "aws_iam_policy_document" "atp-policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::atp-bucket"]
  }
}
resource "aws_iam_user_policy" "lb_ro" {
  name   = "apple"
  user   = aws_iam_user.iam.name
  policy = data.aws_iam_policy_document.atp-policy.json
}
