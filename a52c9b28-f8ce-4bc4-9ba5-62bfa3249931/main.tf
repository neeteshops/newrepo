provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "neetesh00099099"

  tags = {
    Name        = "neetesh00099099"
    Environment = var.environment
  }
}