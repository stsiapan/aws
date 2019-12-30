### create routing
resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.vpc_test.id
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = aws_internet_gateway.my_igw.id
    }
    
    tags = {
        Name = "public-route"
    }
}

### Edit Default Route Table

resource "aws_default_route_table" "default" {
    default_route_table_id = aws_vpc.vpc_test.default_route_table_id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-for-private.id
    }
}

### associate 
resource "aws_route_table_association" "association_to_sub_pub" {
    subnet_id = aws_subnet.pub_sub_test.id
    route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private-in-main" {
    subnet_id      = aws_subnet.priv_sub_test.id
    route_table_id = aws_vpc.vpc_test.main_route_table_id
}