# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

# S3 Bucket without ACL
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  
  tags = merge(var.tags, {
    Workflow = var.workflow_name
  })
}