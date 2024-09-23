
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.dev_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.dev_vpc.cidr_block
}

output "public_subnet_cidr_blocks" {
  description = "A list of subnet CIDR blocks"
  value       = aws_subnet.public[*].cidr_block
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_rt_id" {
  value = aws_route_table.public_rt[*].id
}

output "private_rt_id" {
  value = aws_route_table.private_rt[*].id
}

output "public_subnet_id" {
  value = aws_subnet.public[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private[*].id
}

