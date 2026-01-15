terraform {
  backend "s3" {
    bucket = "terraform-github-actions"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}