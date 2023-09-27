#VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "${var.environment}_vpc"

  cidr = var.vpc["dev"].cidr

  azs             = var.az
  private_subnets = var.vpc["dev"].private_subnets
  public_subnets  = var.vpc["dev"].public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Environment = var.environment
    Name        = "${var.environment}_vpc"
  }

  private_subnet_tags = {
    Environment = var.environment
    Name        = "${var.environment}_private_subnet"
  }

  public_subnet_tags = {
    Environment = var.environment
    Name        = "${var.environment}_public_subnet"
  }

  private_route_table_tags = {
    Environment = var.environment
    Name        = "${var.environment}_private_rt"
  }

  public_route_table_tags = {
    Environment = var.environment
    Name        = "${var.environment}_public_rt"
  }
}


output "vpc_nat_eip" {
  description = "The NAT IP address for outgoing traffic in private subnets"
  value       = flatten(module.vpc.nat_public_ips)
}