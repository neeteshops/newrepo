resource "aws_s3_bucket" "ops0_data_storage_bucket" {
  bucket = "ops0-data-storage"

  tags = {
    Name        = "ops0-data-storage"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "Data Storage"
    ManagedBy   = "Terraform"
    Team        = "Infrastructure"
    CostCenter  = "IT-Ops"
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "ops0_data_storage_versioning" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "ops0_data_storage_public_access_block" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable server-side encryption with KMS
resource "aws_kms_key" "ops0_data_storage_key" {
  description             = "KMS key for ops0-data-storage bucket encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name        = "ops0-data-storage-kms-key"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_kms_alias" "ops0_data_storage_key_alias" {
  name          = "alias/ops0-data-storage-key"
  target_key_id = aws_kms_key.ops0_data_storage_key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ops0_data_storage_encryption" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.ops0_data_storage_key.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Add lifecycle rules for objects
resource "aws_s3_bucket_lifecycle_configuration" "ops0_data_storage_lifecycle" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  rule {
    id     = "archive-old-data"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  rule {
    id     = "delete-incomplete-multipart-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# Configure CORS for API access
resource "aws_s3_bucket_cors_configuration" "ops0_data_storage_cors" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["https://*.${var.o2_domain}", "https://*.${var.project_name}.com"]
    expose_headers  = ["ETag", "Content-Length", "Content-Type"]
    max_age_seconds = 3600
  }
}

# Enable bucket logging
resource "aws_s3_bucket" "ops0_data_storage_logs" {
  bucket = "ops0-data-storage-logs"

  tags = {
    Name        = "ops0-data-storage-logs"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "S3 Access Logs"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "ops0_data_storage_logs_public_access_block" {
  bucket = aws_s3_bucket.ops0_data_storage_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ops0_data_storage_logs_encryption" {
  bucket = aws_s3_bucket.ops0_data_storage_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "ops0_data_storage_logs_lifecycle" {
  bucket = aws_s3_bucket.ops0_data_storage_logs.id

  rule {
    id     = "delete-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_logging" "ops0_data_storage_logging" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  target_bucket = aws_s3_bucket.ops0_data_storage_logs.id
  target_prefix = "log/"
}

# Add object lock configuration for compliance
resource "aws_s3_bucket_object_lock_configuration" "ops0_data_storage_object_lock" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 30
    }
  }
}

# Add bucket policy for access control
resource "aws_s3_bucket_policy" "ops0_data_storage_policy" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceTLS"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.ops0_data_storage_bucket.arn,
          "${aws_s3_bucket.ops0_data_storage_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Add inventory configuration for asset management
resource "aws_s3_bucket_inventory" "ops0_data_storage_inventory" {
  bucket = aws_s3_bucket.ops0_data_storage_bucket.id
  name   = "EntireBucketInventory"
  
  included_object_versions = "All"
  
  schedule {
    frequency = "Weekly"
  }
  
  destination {
    bucket {
      format     = "CSV"
      bucket_arn = aws_s3_bucket.ops0_data_storage_logs.arn
      prefix     = "inventory"
    }
  }
}