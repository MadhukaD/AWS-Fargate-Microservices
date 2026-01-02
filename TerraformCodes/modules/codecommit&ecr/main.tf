resource "aws_codecommit_repository" "code_repo" {
  repository_name = "${var.name_prefix}-code-repo"
  description     = "Microservices for ECS Fargate deployment"
}

resource "aws_ecr_repository" "user_ecr_repo" {
  name                 = "user-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "user-service"
    Environment = "dev"
  }
}

resource "aws_ecr_repository" "product_ecr_repo" {
  name                 = "product-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "product-service"
    Environment = "dev"
  }
}