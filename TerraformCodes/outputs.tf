# VPC and Subnet Outputs
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

output "nat_gateway1_id" {
  description = "NAT Gateway 1 ID"
  value       = module.vpc.nat_gateway1_id
}

output "nat_gateway2_id" {
  description = "NAT Gateway 2 ID"
  value       = module.vpc.nat_gateway2_id
}

# Security Group Outputs
output "security_group1_id" {
  description = "Security Group1 ID"
  value       = module.security.security_group1_id
}

output "security_group2_id" {
  description = "Security Group2 ID"
  value       = module.security.security_group2_id
}

# ALB and Target Group Outputs
output "alb_name" {
  description = "Name of the Application Load Balancer"
  value       = module.alb.alb_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Route53 hosted zone ID of the ALB"
  value       = module.alb.alb_zone_id
}

output "user_target_group_arn" {
  description = "ARN of the user service target group"
  value       = module.alb.user_target_group_arn
}

output "product_target_group_arn" {
  description = "ARN of the product service target group"
  value       = module.alb.product_target_group_arn
}

output "http_listener_arn" {
  description = "ARN of the HTTP listener (port 80)"
  value       = module.alb.http_listener_arn
}

# CodeCommit and ECR Outputs
output "codecommit_repository_name" {
  description = "Name of the CodeCommit repository"
  value       = module.codecommit_ecr.codecommit_repository_name
}

output "codecommit_repository_arn" {
  description = "ARN of the CodeCommit repository"
  value       = module.codecommit_ecr.codecommit_repository_arn
}

output "codecommit_clone_url_http" {
  description = "HTTP clone URL of the CodeCommit repository"
  value       = module.codecommit_ecr.codecommit_clone_url_http
}

output "codecommit_clone_url_ssh" {
  description = "SSH clone URL of the CodeCommit repository"
  value       = module.codecommit_ecr.codecommit_clone_url_ssh
}

output "user_ecr_repository_name" {
  description = "ECR repository name for user service"
  value       = module.codecommit_ecr.user_ecr_repository_name
}

output "user_ecr_repository_arn" {
  description = "ARN of the user service ECR repository"
  value       = module.codecommit_ecr.user_ecr_repository_arn
}

output "user_ecr_repository_url" {
  description = "Repository URL for user service ECR"
  value       = module.codecommit_ecr.user_ecr_repository_url
}

output "product_ecr_repository_name" {
  description = "ECR repository name for product service"
  value       = module.codecommit_ecr.product_ecr_repository_name
}

output "product_ecr_repository_arn" {
  description = "ARN of the product service ECR repository"
  value       = module.codecommit_ecr.product_ecr_repository_arn
}

output "product_ecr_repository_url" {
  description = "Repository URL for product service ECR"
  value       = module.codecommit_ecr.product_ecr_repository_url
}