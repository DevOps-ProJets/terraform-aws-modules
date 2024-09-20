region = "ap-south-1"
azs    = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

create_vpc = true

vpc_cidr                 = "20.0.0.0/16"
vpc_enable_dns_support   = true
vpc_enable_dns_hostnames = true
vpc_tags = {
  Name = "qa-vpc"
}

# create_igw           = true
# create_nat_gateway   = false

# public_subnets_cidr  = ["20.0.10.0/27", "20.0.20.0/24","20.0.21.0/24"]
# public_subnets_azs   = ["us-east-2a", "us-east-2b"]
# enable_map_public_ip_on_launch = true
# public_subnets_tags = [{
#   Name       = "qa-public-subnet-01"
# }, {
#   Name       = "qa-public-subnet-02"
# }, {
#   Name       = "qa-public-subnet-03"
# }]
# igw_tags = {
#   Name       = "qa-igw-01"
# }
# public_route_table_tags = {
#   Name       = "qa-public-RTB-01"
# }
# private_subnets_cidr = ["20.0.1.0/24", "20.0.2.0/24"]
# private_subnets_azs  = "us-east-2a"
# private_subnets_tags = [{
#   Name       = "qa-private-subnet-01"
# }, {
#   Name       = "qa-private-subnet-02"
# }]
# eip_tags = {
#   Name       = "qa-eip-01"
# }
# nat_tags = {
#   Name       = "qa-nat-01"
# }
