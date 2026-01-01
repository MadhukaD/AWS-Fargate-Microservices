output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_01_id" {
  description = "Public subnet 01 ID"
  value       = module.vpc.public_subnet_01_id
}

output "public_subnet_02_id" {
  description = "Public subnet 02 ID"
  value       = module.vpc.public_subnet_02_id
}

output "private_subnet_01_id" {
  description = "Private subnet 01 ID"
  value       = module.vpc.private_subnet_01_id
}

output "private_subnet_02_id" {
  description = "Private subnet 02 ID"
  value       = module.vpc.private_subnet_02_id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.vpc.nat_gateway_id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.security.security_group_id
}

output "ec2_instance_id" {
  description = "Instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "Instance public IP (use to SSH)"
  value       = module.ec2.public_ip
}

output "private_key_file" {
  description = "Local private key file saved by Terraform (use chmod 600 on this file before SSH)"
  value       = module.security.private_key_path
}
