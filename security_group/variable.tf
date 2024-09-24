variable "vpc_id" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "ingress_rule" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    description      = optional(string)  # Optional if using `lookup` for default value
  }))
}

variable "egress_rule" {
  description = "List of egress rules for the security group"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = optional(string)  # Optional if using `lookup` for default value
  }))
}

variable "sg_tag_name" {
  type = string
}

variable "sg_environment" {
  type = string
}