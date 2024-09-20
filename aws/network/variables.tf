variable "region" {
  type = string
}

variable "azs" {
  description = "availability zones"
  type = list(string)
}

/*--------------- create variables ---------------*/

variable "create_vpc" {
  type = bool
}

variable "create_igw" {
  type = bool
}

variable "create_nat_gateway" {
  type = bool
}

/*---------------vpc variables---------------*/

variable "vpc_cidr" {
  type = string
}

variable "vpc_enable_dns_support" {
  type = bool
}

variable "vpc_enable_dns_hostnames" {
  type = bool
}

variable "vpc_tags" {
  type = map(string)
}

/*--------------- Public Subnets ---------------*/

variable "public_subnets_cidr" {
  description = "public subnet cidr block"
  type = list(string)
}


variable "enable_map_public_ip_on_launch" {
  type = bool
}

variable "public_subnets_tags" {
  description = "public subnet tags"
  type = list(map(string))
}

/*--------------- # Internet Gateway ---------------*/

variable "igw_tags" {
  type = map(string)
}

/*--------------- Public Route Table ---------------*/

variable "public_route_table_tags" {
  type = map(string)
}

/*--------------- Private Subnets ---------------*/

variable "private_subnets_cidr" {
  description = "private subnet cidr block"
  type = list(string)
}

variable "private_subnets_tags" {
  description = "private subnet tags"
  type = list(map(string))
}

/*--------------- # EIP  ---------------*/

variable "eip_tags" {
  type = map(string)
}

/*--------------- # NAT Gateway ---------------*/

variable "nat_tags" {
  type = map(string)
}

/*--------------- Private Route Table ---------------*/

variable "private_route_table_tags" {
  type = map(string)
}
