output "vpc-id" {
  value = aws_vpc.vpc.*.id
}

output "public-subnets-id" {
  value = aws_subnet.public-subnets.*.id
}

output "private-subnets-id" {
  value = aws_subnet.private-subnets.*.id
}