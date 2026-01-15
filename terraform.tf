provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-github-actions-jyothi-gunde"
  region = "us-east-1"
}
