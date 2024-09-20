locals {
  region = var.region
}

module "vpc" {
  source = "../"

  ################################################################################
  # VPC
  ################################################################################
  region                   = var.region
  azs                      = var.azs
  create_vpc               = var.create_vpc
  vpc_cidr                 = var.vpc_cidr
  vpc_tags                 = var.vpc_tags
  vpc_enable_dns_support   = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames

  ################################################################################
  # Publiс Subnets
  ################################################################################

  public_subnets_cidr            = var.public_subnets_cidr
  enable_map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  public_subnets_tags            = var.public_subnets_tags

  ################################################################################
  # IGW
  ################################################################################

  create_igw = var.create_igw
  igw_tags   = var.igw_tags

  ################################################################################
  # Public RTB
  ################################################################################

  public_route_table_tags = var.public_route_table_tags

  ################################################################################
  # Private Subnets
  ################################################################################

  private_subnets_cidr = var.private_subnets_cidr
  private_subnets_tags = var.private_subnets_tags

  ################################################################################
  # Private RTB
  ################################################################################

  private_route_table_tags = var.private_route_table_tags

  ################################################################################
  # Elastic IP
  ################################################################################

  eip_tags = var.eip_tags

  ################################################################################
  # NAT Gateways
  ################################################################################

  create_nat_gateway = var.create_nat_gateway
  nat_tags           = var.nat_tags

}

