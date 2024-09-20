locals {
  len_public_subnets  = length(var.public_subnets_cidr)
  len_private_subnets = length(var.private_subnets_cidr)

  max_subnet_length = max(local.len_private_subnets, local.len_public_subnets)

  create_vpc = var.create_vpc
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "vpc" {
  count                = local.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags                 = var.vpc_tags
}

################################################################################
# Publiс Subnets
################################################################################

locals {
  create_public_subnets = local.create_vpc && local.len_public_subnets > 0
}

resource "aws_subnet" "public-subnets" {
  count = local.create_public_subnets && (local.len_public_subnets >= length(var.public_subnets_azs)) ? local.len_public_subnets : 0

  vpc_id                  = aws_vpc.vpc[0].id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.public_subnets_azs[count.index]
  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  tags                    = var.public_subnets_tags[count.index]
}
/*--------------- # Internet Gateway ---------------*/

resource "aws_internet_gateway" "igw" {
  count = local.create_public_subnets && var.create_igw ? 1 : 0

  vpc_id = aws_vpc.vpc[0].id
  tags   = var.igw_tags
}


/*--------------- Public Route Table ---------------*/

resource "aws_route_table" "public-rtb" {
  count = local.create_public_subnets ? 1 : 0

  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = var.public_route_table_tags
}


/*--------------- Route IGW Public RTB ---------------*/
locals {
  create_igw = local.create_public_subnets && var.create_igw
}

resource "aws_route" "public-rtb-igw" {
  count = local.create_vpc && local.create_igw ? 1 : 0

  route_table_id         = element(aws_route_table.public-rtb[*].id, count.index)
  destination_cidr_block = var.existing_vpc_cidr
  gateway_id             = element(aws_internet_gateway.igw[*].id, count.index)
}

/*--------------- Public RTB + Subnet Association ---------------*/

resource "aws_route_table_association" "public-route-association-01" {
  count = local.create_public_subnets ? local.len_public_subnets : 0

  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.public-rtb[0].id
}


################################################################################
# Private Subnets
################################################################################

locals {
  create_private_subnets = local.create_vpc && local.len_private_subnets > 0
}

resource "aws_subnet" "private-subnets" {
  count = local.create_private_subnets ? local.len_private_subnets : 0

  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.private_subnets_azs
  tags              = var.private_subnets_tags[count.index]
}

/*--------------- Private RTB ---------------*/

resource "aws_route_table" "private-rtb" {
  count = local.create_private_subnets ? 1 : 0

  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = var.private_route_table_tags
}

/*--------------- Private RTB Association ---------------*/

resource "aws_route_table_association" "private-route-association-01" {
  count = local.create_private_subnets ? local.len_private_subnets : 0

  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private-rtb.*.id, 0)
}

/*--------------- Elastic IP ---------------*/

resource "aws_eip" "elastic-ip" {
  count  = local.create_nat_gateway ? 1 : 0
  domain = "vpc"
  tags = var.eip_tags
}

# /*--------------- NAT Gateway ---------------*/
locals {
  create_nat_gateway = local.create_private_subnets && var.create_nat_gateway && local.create_igw
}

resource "aws_nat_gateway" "nat" {
  count         = local.create_nat_gateway && local.create_igw ? 1 : 0
  allocation_id = element(aws_eip.elastic-ip[*].id, 0)
  subnet_id     = element(aws_subnet.public-subnets[*].id, 0)
  tags          = var.nat_tags
}

resource "aws_route" "private-nat-gateway" {
  count = local.create_vpc && local.create_nat_gateway ? 1 : 0

  route_table_id         = element(aws_route_table.private-rtb[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, count.index)

}

