resource "aws_s3_bucket" "n33tesh33_bucket" {
  bucket = "n33tesh33"

  tags = {
    Name        = "n33tesh33"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "n33tesh33_versioning" {
  bucket = aws_s3_bucket.n33tesh33_bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "n33tesh33_public_access_block" {
  bucket = aws_s3_bucket.n33tesh33_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}