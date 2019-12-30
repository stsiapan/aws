## creating vpc
resource "aws_vpc" "vpc_test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "my_vpc"
  }
}

### creating public subnet

resource "aws_subnet" "pub_sub_test" {
    vpc_id = aws_vpc.vpc_test.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this public subnet
    availability_zone = "us-east-1a"

    tags = {
        Name = "pub_sub_test"
    }
}

### creating private subnet

resource "aws_subnet" "priv_sub_test" {
    vpc_id = aws_vpc.vpc_test.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false" //it makes this public subnet
    availability_zone = "us-east-1b"

    tags = {
        Name = "priv_sub_test"
    }
}