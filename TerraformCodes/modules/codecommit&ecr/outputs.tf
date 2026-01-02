output "codecommit_repository_name" {
  description = "Name of the CodeCommit repository"
  value       = aws_codecommit_repository.code_repo.repository_name
}

output "codecommit_repository_arn" {
  description = "ARN of the CodeCommit repository"
  value       = aws_codecommit_repository.code_repo.arn
}

output "codecommit_clone_url_http" {
  description = "HTTP clone URL of the CodeCommit repository"
  value       = aws_codecommit_repository.code_repo.clone_url_http
}

output "codecommit_clone_url_ssh" {
  description = "SSH clone URL of the CodeCommit repository"
  value       = aws_codecommit_repository.code_repo.clone_url_ssh
}

output "user_ecr_repository_name" {
  description = "ECR repository name for user service"
  value       = aws_ecr_repository.user_ecr_repo.name
}

output "user_ecr_repository_arn" {
  description = "ARN of the user service ECR repository"
  value       = aws_ecr_repository.user_ecr_repo.arn
}

output "user_ecr_repository_url" {
  description = "Repository URL for user service ECR"
  value       = aws_ecr_repository.user_ecr_repo.repository_url
}

output "product_ecr_repository_name" {
  description = "ECR repository name for product service"
  value       = aws_ecr_repository.product_ecr_repo.name
}

output "product_ecr_repository_arn" {
  description = "ARN of the product service ECR repository"
  value       = aws_ecr_repository.product_ecr_repo.arn
}

output "product_ecr_repository_url" {
  description = "Repository URL for product service ECR"
  value       = aws_ecr_repository.product_ecr_repo.repository_url
}
