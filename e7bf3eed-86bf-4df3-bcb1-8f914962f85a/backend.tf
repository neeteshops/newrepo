terraform {
  backend "s3" {
    bucket = "opszero-e362d043-aaf8-4386-a2ed-5ebeb1ec92d0"
    key    = "e362d043-aaf8-4386-a2ed-5ebeb1ec92d0/e7bf3eed-86bf-4df3-bcb1-8f914962f85a/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}