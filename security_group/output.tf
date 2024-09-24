output "security_group_ids" {
  description = "The IDs of the created security groups"
  value       = aws_security_group.security_group[*].id
}

output "security_group_names" {
  description = "The names of the created security groups"
  value       = aws_security_group.security_group[*].name
}

output "security_group_arn" {
  description = "The ARNs of the created security groups"
  value       = aws_security_group.security_group[*].arn
}