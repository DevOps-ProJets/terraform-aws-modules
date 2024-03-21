locals {
  len_public_subnets      = length(var.public_subnets_cidr)
  # len_private_subnets     = length(var.private_subnets)
  # len_database_subnets    = length(var.database_subnets)

  # max_subnet_length = max(local.len_private_subnets, local.len_public_subnets, local.len_database_subnets)

  create_vpc = var.create_vpc
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "dev-vpc" {
  count = local.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = var.vpc_tags
}

################################################################################
# Publiс Subnets
################################################################################

locals {
  create_public_subnets = local.create_vpc && local.len_public_subnets > 0
}

resource "aws_subnet" "dev_public_subnets" {
  count = local.create_public_subnets && (local.len_public_subnets >= length(var.public_subnets_azs)) ? local.len_public_subnets : 0

  vpc_id                  = aws_vpc.dev-vpc[0].id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.public_subnets_azs[count.index]
  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  tags                    = var.public_subnets_tags[count.index]
}
