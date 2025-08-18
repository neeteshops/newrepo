provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "bucket9909999009"
}

resource "aws_s3_bucket" "neetesh_bucket" {
  bucket = "neetesh88878"
}