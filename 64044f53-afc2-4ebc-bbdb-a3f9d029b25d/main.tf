provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "neetesh0989" {
  bucket = "neetesh0989"
}