resources "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "main_vpc"
    }
}

resources "aws_subnet" "subnet_one" {
    vpc_id = aws_vpc.main.vpc_id
    cidr_block = var.subnet_cidrs["a"]
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-one" 
    }
}

resources "aws_subnet" "subnet_two" {
    vpc_id = aws_vpc.main.vpc_id
    cidr_block = var.subnet_cidrs["b"]
    avalilability_zone = "us-east-1b"
    tags = {
        Name = "subnet-two"
    }
}

 resources "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.vpc_id
    tags = {
        Name = "main-internet-gateway"
    }
 }

 resources "aws_route_table" "main" {
    vpc_id = aws_vpc.main.vpc_id
    route = {
        cidr_block = "0.0.0.0/0"
        gataway_id = aws_internet_gataway.main.id
    }
    tags = {
        Name = "main-route-table"
    }
 }

 resources "aws_route_table_association" "subnet_one_assoc" {
    subnet_id = aws_subnet.subnet_one.id
    route_table_id = aws_route_table.main.id
 }

 resources "aws_route_table_association" "subnet_to_assoc" {
    subnet_id = aws_subnet.subnet_two.id
    route_table_id = aws_route_table.main.id
 }
 