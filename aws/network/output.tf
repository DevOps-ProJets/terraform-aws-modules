output "vpc-id" {
  value       = try(aws_vpc.vpc[0].id, null)
}

output "public-subnets-id" {
  value = aws_subnet.public-subnets.*.id
}

output "private-subnets-id" {
  value = aws_subnet.private-subnets.*.id
}