resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.vpc_name
    Environment = var.vpc_environment
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr)
  availability_zone       = element(var.public_sub_az, count.index )
  cidr_block              = element(var.public_subnet_cidr, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.dev_vpc.id

  tags = merge(
    {
    Type = "Public"
    Name = format("%s-subnet-%d", var.public_subnet_name,count.index+1)
  },
    var.public_subnet_tags,

  )
}


/*-------------------------------------------------------*/

resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidr)
  availability_zone       = element(var.private_sub_az, count.index )
  cidr_block              = element(var.private_subnet_cidr, count.index)
  vpc_id                  = aws_vpc.dev_vpc.id

 tags = merge(
    {
      Name        = element(var.private_subnet_tags, count.index)["name"]
      Environment = element(var.private_subnet_tags, count.index)["environment"]
    },
    element(var.private_subnet_tags, count.index)
  )

}




/*-------------------------------------------------------*/

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name =  var.igw_name
    Environment = var.igw_environment
  }
}

/*-------------------------------------------------------*/

resource "aws_eip" "elasticip" {
  domain = "vpc"
  tags = {
    Name = var.elasticip_name
    Environment = var.elasticip_environment
  }
}

/*-------------------------------------------------------*/

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = element(aws_subnet.public.*.id,0)

  tags = {
    Name = var.nat_gateway_name
    Environment = var.nat_gateway_environment
  }
}

# /*-------------------------------------------------------*/

resource "aws_route_table" "public_rt" {
  count = length(var.public_rt_tag)
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_rt_tag[count.index].name
    Environment = var.public_rt_tag[count.index].environment
  }
}


# /*-------------------------------------------------------*/

resource "aws_route_table" "private_rt" {
  count = length(var.private_rt_tag)
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = var.private_rt_tag[count.index].name
    Environment = var.private_rt_tag[count.index].environment
  }
}

# /*-------------------------------------------------------*/

resource "aws_route_table_association" "public_route_table_assosciation" {
  count = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = element(aws_route_table.public_rt[*].id, count.index)
}

resource "aws_route_table_association" "private_route_table_assosciation" {
  count = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private_rt[*].id, count.index)
}

# /*-------------------------------------------------------*/
# Public Nacl

resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.dev_vpc.id

  dynamic "ingress" {
    for_each = var.public_nacl_ingress_rules
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.public_nacl_egress_rules
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = merge(
    {
      Name        = var.public_nacl_tags["name"]
      Environment = var.public_nacl_tags["environment"]
    },
    var.public_nacl_tags
  )
}

# /*-------------------------------------------------------*/
# public nacl subnet assosciation

resource "aws_network_acl_association" "nacl_public_subnet_assoscition_1" {
  count = length(aws_subnet.public)
  network_acl_id = aws_network_acl.public_nacl.id
  subnet_id      = element(aws_subnet.public[*].id , count.index)
}

# /*-------------------------------------------------------*/
# private Nacl

resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.dev_vpc.id
  subnet_ids = [ aws_subnet.private[0].id, aws_subnet.private[1].id ]

  dynamic "ingress" {
    for_each = var.private_nacl_ingress_rules
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.private_nacl_egress_rules
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = merge(
    {
      Name        = var.private_nacl_tags["name"]
      Environment = var.private_nacl_tags["environment"]
    },
    var.private_nacl_tags
  )
}
