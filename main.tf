/*--------------- VPC ---------------*/

resource "aws_vpc" "vpc-01" {
  count = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = var.vpc_tags
}