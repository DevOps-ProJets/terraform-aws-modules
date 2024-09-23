output "node_group_names" {
  description = "Names of the created EKS node groups"
  value       = aws_eks_node_group.node_groups[*].node_group_name
}

output "node_group_status" {
  description = "Status of each EKS node group"
  value       = aws_eks_node_group.node_groups[*].status
}

output "node_group_arns" {
  description = "ARNs of the created EKS node groups"
  value       = aws_eks_node_group.node_groups[*].arn
}