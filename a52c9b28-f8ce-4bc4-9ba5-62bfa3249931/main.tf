provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "neetesh0099098812"

  tags = {
    Name        = "neetesh0099098812"
    Environment = var.environment
  }
}