variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "vpc" {
  default = {
    "dev" = {
      "cidr" : "10.31.0.0/16"
      "public_subnets" : ["10.31.48.0/20"]
      "private_subnets" : ["10.31.0.0/20"]
      # the first subnet on the list would be accessible over vpn peering
    },
  }
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}


variable "az" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

########### AWS EC2 Instance Terraform Variables ##########

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "brainstorm"
}