terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "bucket00097653er"

  tags = {
    Name        = "bucket00097653er"
    Environment = var.environment
  }
}