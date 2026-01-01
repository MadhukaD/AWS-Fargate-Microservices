variable "name_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "public_subnet_01_cidr" {
  type = string
}

variable "public_subnet_02_cidr" {
  type = string
}

variable "private_subnet_01_cidr" {
  type = string
}

variable "private_subnet_02_cidr" {
  type = string
}

variable "map_public_ip_on_launch" {
  type = bool
}