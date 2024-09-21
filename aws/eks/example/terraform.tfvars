# Region and Availability Zones
region = "ap-south-1"
azs    = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

# Creation Flags
create_vpc         = true
create_igw         = true
create_nat_gateway = true

# VPC Configuration
vpc_cidr                 = "20.0.0.0/16"
vpc_enable_dns_support   = true
vpc_enable_dns_hostnames = true
vpc_tags = {
  Name = "qa-vpc"
}

# Public Subnets
public_subnets_cidr            = ["20.0.10.0/24", "20.0.20.0/24", "20.0.21.0/24"]
enable_map_public_ip_on_launch = true
public_subnets_tags = [{
  Name = "qa-public-subnet-01"
  }, {
  Name = "qa-public-subnet-02"
  }, {
  Name = "qa-public-subnet-03"
}]

# Internet Gateway
igw_tags = {
  Name = "qa-igw-01"
}

# Public Route Table
public_route_table_tags = {
  Name = "qa-public-RTB-01"
}

# Private Subnets
private_subnets_cidr = ["20.0.1.0/24", "20.0.2.0/24"]
private_subnets_tags = [{
  Name = "qa-private-subnet-01"
  }, {
  Name = "qa-private-subnet-02"
}]

# Elastic IP and NAT Gateway
eip_tags = {
  Name = "qa-eip-01"
}
nat_tags = {
  Name = "qa-nat-01"
}

# Private Route Table
private_route_table_tags = {
  Name = "qa-private-RTB-01"
}

# ------------- EKS IAM Role -------------------------------
eks_cluster_role_name            = "qa-eks-cluster-role"

# ------------- EKS Cluster -------------------------------
eks_cluster_name                 = "qa-eks-cluster"
eks_cluster_version              = "1.29"

# ---------- EKS Node Group IAM Policy ---------------------
eks_node_group_role_name         = "qa-eks-node-group-role"

# ------------- EKS Node Group -------------------------------
eks_node_group_name              = "qa-eks-node-group"
eks_node_group_desired_size      = 2
eks_node_group_max_size          = 3
eks_node_group_min_size          = 1
eks_node_group_max_unavailable   = 1
eks_node_group_instance_types    = ["t3.micro"]
eks_node_group_capacity_type     = "ON_DEMAND"  # or "SPOT"
eks_node_group_disk_size         = 20
