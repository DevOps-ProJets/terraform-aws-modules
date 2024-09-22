# ------------- eks  IAM role -------------------------------

variable "eks_cluster_role_name"{
  type = string
}

# ------------- eks Cluster -------------------------------

variable "eks_cluster_name"{
  type = string
}

variable "eks_subnet_ids"{
  type = list(string)
}

variable "eks_cluster_version"{
  type = string
}

# ---------- eks node grp IAM policy --------------------------------

variable "eks_node_group_role_name"{
  type = string
}

# ------------- eks Node Group -------------------------------

variable "eks_node_groups" {
  type = map(object({
    desired_size = number
    max_size     = number
    min_size     = number
    ami_type     = string
    instance_types = list(string)
    capacity_type  = string
    disk_size      = number
    subnet_ids     = list(string)
    max_unavailable = number
  }))
}

