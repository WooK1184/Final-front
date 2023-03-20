#CREATE_VPC
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "teamF_vpc"
    }
}

#INTERNET_GATEWAY
resource "aws_internet_gateway" "teamF-igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "teamF-IGW"
    }
}

#NAT_GATEWAY_EIP
resource "aws_eip" "nat" {
    vpc = true
}

#NAT_GATEWAY
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.NAT-pub.id
    tags = {
        Name = "teamF-NAT"
    }
}