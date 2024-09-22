resource "aws_security_group" "security-group" {
  name        = var.sg_name
  description = try(var.sg_description, null)
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    iterator = ingress_rule
    content {
      from_port        = ingress_rule.value.from_port
      to_port          = ingress_rule.value.to_port
      protocol         = ingress_rule.value.protocol
      cidr_blocks      = try(ingress_rule.value.cidr_blocks, null)
      ipv6_cidr_blocks = try(ingress_rule.value.ipv6_cidr_blocks, null)
      security_groups  = try(ingress_rule.value.security_groups, null)
    }
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
