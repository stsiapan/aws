### creating gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.vpc_test.id
    tags = {
        Name = "my-igw"
    }
}

# Enable NAT-GW
resource "aws_eip" "EIP" {
        vpc = true
        depends_on = [aws_internet_gateway.my_igw]
    }
resource "aws_nat_gateway" "nat-for-private" {
        allocation_id = aws_eip.EIP.id
        subnet_id     = aws_subnet.pub_sub_test.id
      
        depends_on =  [aws_internet_gateway.my_igw]
}
