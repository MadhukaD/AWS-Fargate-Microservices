#####################################
# VPC
#####################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-vpc"
    }
  )
}

#####################################
# Internet Gateway
#####################################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-igw"
    }
  )
}

#####################################
# Public Subnets
#####################################
resource "aws_subnet" "public" {
  for_each = {
    for idx, az in var.azs :
    idx => {
      az   = az
      cidr = var.public_subnets_cidr[idx]
    }
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-public-subnet-${each.key + 1}"
      Tier = "public"
    }
  )
}

#####################################
# Private Subnets
#####################################
resource "aws_subnet" "private" {
  for_each = {
    for idx, az in var.azs :
    idx => {
      az   = az
      cidr = var.private_subnets_cidr[idx]
    }
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-private-subnet-${each.key + 1}"
      Tier = "private"
    }
  )
}

#####################################
# EIPs for NAT
#####################################
resource "aws_eip" "nat" {
  for_each = aws_subnet.public

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-nat-eip-${each.key + 1}"
    }
  )
}

#####################################
# NAT Gateways (one per AZ)
#####################################
resource "aws_nat_gateway" "this" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-nat-gw-${each.key + 1}"
    }
  )

  depends_on = [aws_internet_gateway.this]
}

#####################################
# Public Route Table + Associations
#####################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-public-rt"
    }
  )
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

#####################################
# Private Route Tables + Associations
# one per private subnet, each → its NAT
#####################################
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-private-rt-${each.key + 1}"
    }
  )
}

resource "aws_route" "private_nat_access" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}