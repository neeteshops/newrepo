variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "bucket00097653er"
}

variable "environment" {
  description = "Environment (e.g. dev, test, prod)"
  type        = string
  default     = "dev"
}