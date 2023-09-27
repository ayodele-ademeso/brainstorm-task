
# Terraform Block
terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    bucket = "ayodele-terraform-eks"
    key    = "dev/brainstorm.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.59"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}