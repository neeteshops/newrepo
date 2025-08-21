# S3 Bucket Terraform Configuration

This directory contains Terraform configuration to create an AWS S3 bucket named "neetesh665654" without ACL configuration.

## Resources Created

- AWS S3 bucket with name "neetesh665654"

## Configuration Details

- The bucket is created without ACL configuration as requested
- Basic tags are applied for resource management
- Default AWS region is set to us-west-2 (can be modified in main.tf)

## Usage

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply

# Destroy resources when no longer needed
terraform destroy
```

## Outputs

- `bucket_id`: The name of the created bucket
- `bucket_arn`: The ARN of the created bucket
- `bucket_region`: The AWS region where the bucket resides