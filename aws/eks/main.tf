# ------------- eks  IAM role -------------------------------

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks-cluster-role" {
  name               = var.eks_cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
# resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.eks-cluster-role.name
# }


resource "aws_eks_cluster" "aws-eks-cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids = var.eks_subnet_ids # Needs at least 2 subnets in 2 AZs
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

# ---------- eks node grp IAM policy --------------------------------

resource "aws_iam_role" "eks-node-group-role" {
  name = var.eks_node_group_role_name

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}

# --------------------- eks node group ----------------------------------

resource "aws_eks_node_group" "eks-node-group" {
  for_each       = var.eks_node_groups
  cluster_name   = aws_eks_cluster.aws-eks-cluster.name
  node_group_name = each.key
  node_role_arn  = aws_iam_role.eks-node-group-role.arn
  subnet_ids     = each.value.subnet_ids

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  update_config {
    max_unavailable = each.value.max_unavailable
  }

  ami_type       = each.value.ami_type
  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type
  disk_size      = each.value.disk_size
  
  labels = each.value.node_labels
  
  remote_access {
    ec2_ssh_key = each.key_name
    source_security_group_ids = each.security_group_ids
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # This will prevent node destruction on role or policy changes
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  # Enable 'create_before_destroy' to prevent nodes from being destroyed during updates
  lifecycle {
    create_before_destroy = true
  }
}