output "eks-cluster-role-arn" {
  value = aws_iam_role.eks-cluster-role.arn
}

output "endpoint" {
  value = aws_eks_cluster.aws-eks-cluster.endpoint
}

output "eks-cluster-name" {
  value = aws_eks_cluster.aws-eks-cluster.id
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.aws-eks-cluster.certificate_authority[0].data
}

output "eks-node-group-id" {
  value = aws_eks_node_group.eks-node-group.id
}