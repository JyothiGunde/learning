provider "aws" {
  region = "us-east-1"
}
/*
resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-github-actions-jyothi-gunde"
}
*/

resource "aws_instance" "ec2" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t2.nano"
}