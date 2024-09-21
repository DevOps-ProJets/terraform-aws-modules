# ------------- eks  IAM role -------------------------------

variable "eks_cluster_role_name"{
  type = string
}

# ------------- eks Cluster -------------------------------

variable "eks_cluster_name"{
  type = string
}

variable "eks_cluster_version"{
  type = string
}

# ---------- eks node grp IAM policy --------------------------------

variable "eks_node_group_role_name"{
  type = string
}

# ------------- eks Node Group -------------------------------

variable "eks_node_group_name"{
  type = string
}

variable "eks_node_group_desired_size"{
  type = number
}

variable "eks_node_group_max_size"{
  type = number
}

variable "eks_node_group_min_size"{
  type = number
}

variable "eks_node_group_max_unavailable"{
  type = number
}

variable "eks_node_group_instance_types"{
  type = list(string)
}

variable "eks_node_group_capacity_type"{
  type = string
}

variable "eks_node_group_disk_size"{
  type = number
}
