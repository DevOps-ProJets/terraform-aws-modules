output "example-vpc-id" {
  value = module.vpc.vpc-id
}

output "example-public-subnet-id" {
  value = module.vpc.public-subnets-id[*]
}

output "example-private-subnet-id" {
  value = module.vpc.private-subnets-id[*]
}
