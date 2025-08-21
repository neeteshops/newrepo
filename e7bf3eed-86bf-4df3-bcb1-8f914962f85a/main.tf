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
  region = "us-west-2"  # You can change this to your preferred region
}

# S3 bucket without ACL configuration
resource "aws_s3_bucket" "bucket" {
  bucket = "neetesh665654"
  
  # No ACL configuration is included
  
  tags = {
    Name        = "neetesh665654"
    Environment = "Dev"
    CreatedBy   = "Terraform"
  }
}