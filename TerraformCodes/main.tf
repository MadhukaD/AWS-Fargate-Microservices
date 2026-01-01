# ────────────────────────────────
# VPC + Subnets + IGW + NAT
# ────────────────────────────────
module "vpc" {
  source = "./modules/vpc"

  name_prefix             = var.name_prefix
  vpc_cidr                = var.vpc_cidr
  aws_region              = var.aws_region

  public_subnet_01_cidr   = var.public_subnet_01_cidr
  public_subnet_02_cidr   = var.public_subnet_02_cidr
  private_subnet_01_cidr  = var.private_subnet_01_cidr
  private_subnet_02_cidr  = var.private_subnet_02_cidr

  map_public_ip_on_launch = var.map_public_ip_on_launch
}

# ────────────────────────────────
# Security Groups + Key Pair
# ────────────────────────────────
module "security" {
  source = "./modules/security"

  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
}

# ────────────────────────────────
# EC2 Instance
# ────────────────────────────────
module "ec2" {
  source = "./modules/ec2"

  name_prefix       = var.name_prefix
  ami_id            = var.ami_id
  instance_type     = var.instance_type

  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
  delete_on_termination = var.delete_on_termination

  subnet_id         = module.vpc.public_subnet_01_id
  security_group_id = module.security.security_group_id

  key_name          = module.security.key_name
}