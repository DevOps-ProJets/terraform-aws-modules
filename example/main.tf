provider "aws" {
  region = local.region
}
locals {
#   name   = "ex-${basename(path.cwd)}"
  region = "us-east-2"
}

module "vpc" {
    source = "../"

    ################################################################################
    # VPC
    ################################################################################

    create_vpc                     = var.create_vpc
    vpc_cidr                       = var.vpc_cidr
    vpc_tags                       = var.vpc_tags
    vpc_enable_dns_support         = var.vpc_enable_dns_support
    vpc_enable_dns_hostnames       = var.vpc_enable_dns_hostnames

    ################################################################################
    # Publiс Subnets
    ################################################################################
    
    public_subnets_cidr            = var.public_subnets_cidr
    public_subnets_azs              = var.public_subnets_azs
    enable_map_public_ip_on_launch = var.enable_map_public_ip_on_launch
    public_subnets_tags            = var.public_subnets_tags
    
}

