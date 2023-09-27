# Define Local Values in Terraform
locals {
  owners      = "ayodele"
  environment = var.environment
  name        = "brainstorm"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}