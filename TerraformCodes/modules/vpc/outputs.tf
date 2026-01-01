output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs in AZ order"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs in AZ order"
  value       = [for s in aws_subnet.private : s.id]
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs (per AZ)"
  value       = [for n in aws_nat_gateway.this : n.id]
}

output "nat_eip_addresses" {
  description = "Public IPs of NAT Gateways"
  value       = [for e in aws_eip.nat : e.public_ip]
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private route table IDs (per AZ)"
  value       = [for rt in aws_route_table.private : rt.id]
}