resource "aws_vpc" "exam_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "exam-vpc-komalpreet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.exam_vpc.id
  tags = {
    Name = "exam-igw-komalpreet"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.exam_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "exam-public-subnet-komalpreet"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.exam_vpc.id
  tags = {
    Name = "exam-public-rt-komalpreet"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
