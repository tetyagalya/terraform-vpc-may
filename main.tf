provider aws {
    region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-1"
  }
}


resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-2"
  }
}

resource "aws_subnet" "main3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet3_cidr
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.example.id
}