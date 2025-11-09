resource "aws_vpc" "main" {
 cidr_block = var.cidr
 enable_dns_hostnames = true
 
 tags = merge(
    local.common_tags,
    var.vpc_tags, {
        Name = local.common_name_suffix
    }
 )
}


# Internet Gate way
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    {
        Name = local.common_name_suffix
    }
 )
}

#public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

 tags = merge(
    var.public_subnet_tags,
     {
        Name = "${local.common_name_suffix}-public-${local.az_names[count.index]}"  #roboshop-dev-public-us-east-1a/1b
    }
 )
}

#private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

 tags = merge(
    var.private_subnet_tags,
    {
        Name = "${local.common_name_suffix}-private-${local.az_names[count.index]}"  #roboshop-dev-private-us-east-1a/1b
    }
 )
}


#database(private) subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

 tags = merge(
    var.database_subnet_tags,
    {
        Name = "${local.common_name_suffix}-database-${local.az_names[count.index]}"  #roboshop-dev-private-us-east-1a/1b
    }
 )
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-public"
    }
  )
}

# Public Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-private"
    }
  )
}

# Public Route Table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-database"
    }
  )
}


#  public rout
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"  # Or a specific CIDR block like "10.0.1.0/24"
  gateway_id             = aws_internet_gateway.main.id # Or other target types
}


# Elastic IP
resource "aws_eip" "nat" {
  domain = "vpc"

    tags = merge(
    var.eip_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-nat"
    }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # Replace with your public subnet resource


  tags = merge(
    var.nat_gateway_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-natgateway"
    }
  )

  depends_on = [aws_internet_gateway.main]
}


#  private(private) egress through nat
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"  # Or a specific CIDR block like "10.0.1.0/24"
  gateway_id             =  aws_nat_gateway.nat_gateway.id # Or other target types
}



#  database(private) egress through nat 
resource "aws_route" "database" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"  # Or a specific CIDR block like "10.0.1.0/24"
  gateway_id             =  aws_nat_gateway.nat_gateway.id # Or other target types
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}