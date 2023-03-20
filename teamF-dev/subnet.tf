resource "aws_subnet" "NAT-pub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true
    tags = {Name = "NAT-pub"}
}

resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true
    tags = {Name = "pub2"}
}

resource "aws_subnet" "sv-private1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = false
    tags = {Name = "sv-private1"}
}

resource "aws_subnet" "sv-private2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.21.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = false
    tags = {Name = "sv-private2"}
}

resource "aws_subnet" "db-private1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.12.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = false
    tags = {Name = "db-private1"}
}

resource "aws_subnet" "db-private2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.22.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = false
    tags = {Name = "db-private2"}
}

resource "aws_route_table" "public1" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.teamF-igw.id   
    }
    tags = {Name = "teamF-public1"} 
}

resource "aws_route_table" "public2" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.teamF-igw.id   
    }
    tags = {Name = "teamF-public2"} 
}

resource "aws_route_table" "private1" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id   
    }
    tags = {Name = "teamF-private1"} 
}

resource "aws_route_table" "private2" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id   
    }
    tags = {Name = "teamF-private2"} 
}

resource "aws_route_table" "private3" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id   
    }
    tags = {Name = "teamF-private3"} 
}

resource "aws_route_table" "private4" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id   
    }
    tags = {Name = "teamF-private4"} 
}

resource "aws_route_table_association" "teamf-routing-public1" { 
  subnet_id      = aws_subnet.NAT-pub.id
  route_table_id = aws_route_table.public1.id
}

resource "aws_route_table_association" "teamf-public2" { 
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.public2.id
}

resource "aws_route_table_association" "teamf-sv-private1" { 
  subnet_id      = aws_subnet.sv-private1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "teamf-sv-private2" { 
  subnet_id      = aws_subnet.sv-private2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "teamf-db-private1" { 
  subnet_id      = aws_subnet.db-private1.id
  route_table_id = aws_route_table.private3.id
}

resource "aws_route_table_association" "teamf-db-private2" { 
  subnet_id      = aws_subnet.db-private2.id
  route_table_id = aws_route_table.private4.id
}

#sv_subnetgroup
resource "aws_db_subnet_group" "rds" {
    name = "db_subnetgroup"
    description = "use in RDS instance"
    subnet_ids = [aws_subnet.db-private1.id, aws_subnet.db-private2.id]
}

#ecs_subnetgroup
resource "aws_ecs_subnet_group" "ecs" {
    name = "ecs_subnetgroup"
    subnet_ids = [aws_subnet.sv-private1.id, aws_subnet.sv-private2.id]
}