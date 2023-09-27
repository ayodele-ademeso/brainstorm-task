########### AWS EC2 Instance Terraform Outputs ###########
########### Public EC2 Instance - ec2 Host###########

output "ec2_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

output "ec2_eip" {
  description = "Elastic IP associated to the ec2 Host"
  value       = aws_eip.ec2_eip.public_ip
}