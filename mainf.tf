resource "aws_vpc" "vpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = var.vpc_cidr_block
  tags = merge(local.tags, {
    Name = var.ressource_identifer
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.tags, {
    Name = var.ressource_identifer
  })
}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.tags, {
    Name = var.ressource_identifer
  })
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt.id
  gateway_id             = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"



  timeouts {
    create = "2m"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each                = toset(var.public_subnets)
  cidr_block              = each.key
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = element(
    local.azs.zones,
    index(var.public_subnets, each.key)
  )
  tags = merge(local.tags, {
    Name = format("%s-public-%s", var.ressource_identifer, index(var.public_subnets, each.key))
  })
}

resource "aws_route_table_association" "public_route_association" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}
