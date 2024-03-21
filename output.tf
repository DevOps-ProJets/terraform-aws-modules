output "vpc-id" {
  value = aws_vpc.dev-vpc.*.id
}

output "public-subnets-id" {
  value = aws_subnet.dev_public_subnets.*.id
}