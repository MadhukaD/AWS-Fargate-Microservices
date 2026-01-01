variable "name_prefix" {
  description = "Prefix for naming security resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach security group"
  type        = string
}
