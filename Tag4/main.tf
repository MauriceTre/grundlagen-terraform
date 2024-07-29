resource "aws_vpc" "kugel" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "kugelfisch1" {
  vpc_id     = aws_vpc.kugel.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "kugelfisch2" {
  vpc_id     = aws_vpc.kugel.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-central-1b"
}

resource "aws_subnet" "kugelfisch1privat" {
  vpc_id     = aws_vpc.kugel.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "kugelfisch2privat" {
  vpc_id     = aws_vpc.kugel.id
  cidr_block = "10.0.3.0/24"
  
}

resource "aws_internet_gateway" "Meer" {
  vpc_id = aws_vpc.kugel.id
}
resource "aws_route_table" "fluss" {
  vpc_id = aws_vpc.kugel.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Meer.id
  }
}
resource "aws_route_table_association" "freiheit" {
  route_table_id = aws_route_table.fluss.id
  subnet_id      = aws_subnet.kugelfisch1.id
}
resource "aws_route_table_association" "freiheit2" {
  route_table_id = aws_route_table.fluss.id
  subnet_id      = aws_subnet.kugelfisch2.id
  
}
