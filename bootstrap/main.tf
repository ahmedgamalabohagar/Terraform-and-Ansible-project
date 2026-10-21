terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#-------------------------------------------------

variable "aws_region" {
  description = "Region for the state bucket..."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "name for the Terraform stateFile S3 bucket"
  type        = string
  default     = "team2-devops-lab-tfstate-2026-barq" 
}

variable "project_name" {
  description = "Prefix used in the bucket name"
  type        = string
  default     = "terraform-and-ansible-project"
}

#--------------------------------------------------------------

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project   = var.project_name
      ManagedBy = "terraform-bootstrap"
    }
  }
}

#------------------------------------------

resource "aws_s3_bucket" "statefile" {
  bucket        = var.state_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "statefile" {
  bucket = aws_s3_bucket.statefile.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "statefile" {
  bucket = aws_s3_bucket.statefile.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "statefile" {
  bucket                  = aws_s3_bucket.statefile.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#----------------------------------------------------------------------------------

output "state_bucket" {
  description = "Bucket name to pass to terraform init..."
  value       = aws_s3_bucket.statefile.id
}

output "region" {
  value = var.aws_region
}