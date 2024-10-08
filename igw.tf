resource "aws_internet_gateway" "eks-gw" {
  vpc_id = aws_vpc.eks_vpc.id


  tags = merge(
    local.tags,
    {
      name = "${var.name_project}-igw"
    }
  )
}

resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-gw.id
  }

  tags = merge(
    local.tags,
    {
      name = "${var.name_project}-public-route-table"
    }
  )
}