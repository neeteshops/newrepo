variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "neetesh0099098812"
}

variable "environment" {
  description = "Environment tag for the S3 bucket"
  type        = string
  default     = "dev"
}