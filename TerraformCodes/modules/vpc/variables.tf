variable "name_prefix" {
  description = "Common name prefix for all network resources"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "Public subnet CIDR blocks (1 per AZ)"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Private subnet CIDR blocks (1 per AZ)"
  type        = list(string)
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}