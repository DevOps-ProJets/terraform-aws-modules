variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  description = "The instance tenancy option for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name to assign to the VPC."
  type        = string
}

variable "vpc_environment" {
   type = string
}

variable "public_subnet_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_sub_az" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
  default     = true
}

variable "public_subnet_name" {
  description = "Base name for the subnets"
  type        = string
}

variable "public_subnet_tags" {
  description = "Additional tags for the subnets"
  type        = map(string)
  default     = {}
}

/*-------------------------------------------------------*/

variable "private_subnet_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_sub_az" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

variable "private_subnet_tags" {
  type = list(map(string))
}


/*-------------------------------------------------------*/

variable "igw_name" {
  description = "The name of the internet gateway"
  type = string
}

variable "igw_environment" {
  description = "The environment name of the internet gateway"
  type = string
}

/*-------------------------------------------------------*/

variable "elasticip_name" {
  description = "The name of the internet gateway"
  type = string
}

variable "elasticip_environment"{
    type = string
}

/*-------------------------------------------------------*/

variable "nat_gateway_name"{
    type = string
}

variable "nat_gateway_environment"{
    type = string
}

/*-------------------------------------------------------*/


variable "public_rt_tag" {
  description = "List of tags for public route tables"
  type = list(object({
    name = string
    environment = string
  }))
}

/*-------------------------------------------------------*/

variable "private_rt_tag" {
  description = "List of tags for public route tables"
  type = list(object({
    name = string
    environment = string
  }))
}

/*-------------------------------------------------------*/
# Public Nacl

variable "public_nacl_ingress_rules" {
  description = "List of nacl ingress rules."
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "public_nacl_egress_rules" {
  description = "List of nacl egress rules."
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "public_nacl_tags" {
  description = "Tags to apply to the network ACL, including name and environment."
  type        = map(string)
  default     = {
    name        = "default-name"
    environment = "default-env"
  }
}


/*-------------------------------------------------------*/
# Private Nacl

variable "private_nacl_ingress_rules" {
  description = "List of nacl ingress rules."
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "private_nacl_egress_rules" {
  description = "List of nacl egress rules."
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "private_nacl_tags" {
  description = "Tags to apply to the network ACL, including name and environment."
  type        = map(string)
  default     = {
    name        = "default-name"
    environment = "default-env"
  }
}
