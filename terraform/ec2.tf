# AWS EC2 Security Group Terraform Module
# Security Group for Public EC2 Host
module "public_ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"
  #version = "4.5.0"  
  version = "4.17.2"

  name        = "${local.name}-public-ec2-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}

# AWS EC2 Instance Terraform Module
# EC2 Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source = "terraform-aws-modules/ec2-instance/aws"
  #version = "~> 3.0"
  #version = "3.3.0"
  version = "5.0.0"

  name          = "${local.name}-instance"
  ami           = "ami-053b0d53c279acc90"
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_ec2_sg.security_group_id]

  tags = local.common_tags
}

# Create Elastic IP for EC2 Host
resource "aws_eip" "ec2_eip" {
  depends_on = [module.ec2_public, module.vpc]
  instance   = module.ec2_public.id
  vpc        = true
  tags       = local.common_tags
}

# Create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.ec2_eip.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("../brainstorm.pem")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "../brainstorm.pem"
    destination = "/tmp/brainstorm.pem"
  }
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on EC2 Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/brainstorm.pem"
    ]
  }

}