variable "ingress_rules" {
  type = map(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    ipv6_cidr_blocks = list(string)
  }))
  description = "SG inbound rules"
}
variable "sg_name" {
  type = string
}

variable "sg_description" {
  type = string
}

variable "vpc_id" {
  type = string
}