variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "neetesh0990909"
}

variable "environment" {
  description = "Environment (e.g. dev, prod, staging)"
  type        = string
  default     = "dev"
}