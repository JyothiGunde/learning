provider "aws" {
  region = "us-east-1"
}
/*
resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-github-actions-jyothi-gunde"
}
*/

resource "aws_instance" "myec2" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  tags = {
    Name = "demo-role"
  }
}

#########################################
# IAM Role for EC2 with CW + SSM Access
#########################################

resource "aws_iam_role" "ec2_role" {
  name = "ec2-cw-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#########################################
# Attach AWS Managed Policies
#########################################

resource "aws_iam_role_policy_attachment" "cw_full" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_full" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

#########################################
# IAM Instance Profile for EC2
#########################################

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-cw-ssm-instance-profile"
  role = aws_iam_role.ec2_role.name
}
