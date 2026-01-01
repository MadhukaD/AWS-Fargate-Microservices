variable "name_prefix" {
  description = "Name prefix used for tagging and resource names"
  type        = string
  default     = "Test-Server"
}

variable "aws_access_key" {
  description = "instance_type of VM"
  type        = string
  default     = "AddYourAccessKey"
}

variable "aws_secret_key" {
  description = "instance_type of VM"
  type        = string
  default     = "AddYourSecretKey" 
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-southeast-2"
}

variable "availability_zones" {
  description = "AZs to use (order matters). Provide at least 2 AZs for HA split."
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.80.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance (provide manually)"
  type        = string
  default     = "ami-01361d3186814b895"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "delete_on_termination" {
  description = "Whether to delete the root volume on termination"
  type        = bool
  default     = true
}

variable "public_subnet_01_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.80.0.0/24"
}

variable "public_subnet_02_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.80.1.0/24"
}

variable "private_subnet_01_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.80.2.0/24"
}

variable "private_subnet_02_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.80.3.0/24"
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}