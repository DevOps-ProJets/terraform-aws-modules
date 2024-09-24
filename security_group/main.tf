resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id
  name   = var.sg_name

  tags = {
    Name        = var.sg_tag_name
    Environment = var.sg_environment
  }

dynamic "ingress" {
  for_each = var.ingress_rule
  content {
    description = lookup(ingress.value, "description", "No description")
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
    security_groups = lookup(ingress.value, "security_groups", null)
   
  }
}

dynamic "egress" {
  for_each = var.egress_rule
  content {
    description = lookup(egress.value, "description", "No description")
    from_port   = egress.value.from_port
    to_port     = egress.value.to_port
    protocol    = egress.value.protocol
    cidr_blocks = egress.value.cidr_blocks
  }
}
}
