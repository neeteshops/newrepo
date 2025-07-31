provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = {
    WorkflowName = "workflow-88877"
  }
}