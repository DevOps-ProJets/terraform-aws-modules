
resource "aws_eks_cluster" "cluster" {
  name     = var.name
  version  = var.eks_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids #[aws_security_group.cluster.id]
    endpoint_private_access = var.cluster_private_access
    endpoint_public_access  = var.cluster_public_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
  ]
}



