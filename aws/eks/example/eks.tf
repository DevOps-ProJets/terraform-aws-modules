locals {
  cluster_name = "qa-eks"
}

module "eks" {
  source = "../"  # Adjust this to the path of your module

  # EKS Cluster Variables
  eks_cluster_role_name            = var.eks_cluster_role_name
  eks_cluster_name                 = var.eks_cluster_name
  eks_cluster_version              = var.eks_cluster_version
  eks_subnet_ids                   = module.vpc.private-subnets-id 

  # EKS Node Group Variables
  node_group_subnet_ids = [module.vpc.private-subnets-id[0]]
  eks_node_group_role_name         = var.eks_node_group_role_name
  eks_node_group_name              = var.eks_node_group_name
  eks_node_group_desired_size      = var.eks_node_group_desired_size
  eks_node_group_max_size          = var.eks_node_group_max_size
  eks_node_group_min_size          = var.eks_node_group_min_size
  eks_node_group_max_unavailable   = var.eks_node_group_max_unavailable
  eks_node_group_instance_types    = var.eks_node_group_instance_types
  eks_node_group_capacity_type     = var.eks_node_group_capacity_type
  eks_node_group_disk_size         = var.eks_node_group_disk_size
}
