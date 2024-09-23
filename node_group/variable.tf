variable "node_role_arn" {
  description = "node_role_arn"
  type        = string
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "ami_type" {
  description = "desired ami"
  type = string
}

variable "labels" {
  description = "labels of the node"
  type = map(string)
}

variable "security_group_ids" {
  description = "node"
  type = list(string)
  
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
# variable "subnet_ids" {
#   description = "subnet ids"
#   type        = list(string)
# }

variable "instance_types" {
  description = "instance type"
  type        = list(string)
}

variable "disk_size" {
  description = "disk size of instance"
  type        = string
}

variable "desired_size" {
  description = "desired size of node group"
  type        = string
}

variable "max_size" {
  description = "max size of node group"
  type        = string
}

variable "min_size" {
  description = "min size of node group"
  type        = string
}

variable "ec2_ssh_key" {
  description = "ssh key for node group"
  type        = string
}