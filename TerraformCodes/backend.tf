terraform {
  backend "s3" {
    bucket         = "fargate-microservices-terraform-states"
    key            = "prod/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "fargate-microservices-terraform-locks"
    encrypt        = true
  }
}
