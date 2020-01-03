### web (public instance)

resource "aws_instance" "web-public" {
    ami = "ami-00eb20669e0990cb4"
    instance_type = "t2.micro"   
    # VPC
    subnet_id = aws_subnet.pub_sub_test.id  
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]  
    # the Public SSH key
    key_name = "key_pair"   
    # nginx installation
    provisioner "file" {
        source      = "nginx.conf"
        destination = "/tmp/nginx.conf"
    }    
    provisioner "remote-exec" {
        inline = [
             "sudo yum install -y nginx",
             "openssl req -subj '/CN=stsiapan.by/O=Stsiapan Inc./C=BY' -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout server.key -out server.crt",
             "sudo mv /tmp/nginx.conf /etc/nginx/",
             "sudo service nginx start"
        ]
    }
    connection {
      host = aws_instance.web-public.public_ip
      user = "ec2-user"
      private_key = file("key_pair.pem")
    }
    
    tags = {
      Name = "Nginx"
  }     
}

### jenkins (private instance)

resource "aws_instance" "web-private" {
    ami = "ami-09510373329630e0f"
    instance_type = "t2.micro"   
    # VPC
    subnet_id = aws_subnet.priv_sub_test.id  
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]  
    # the Public SSH key
    key_name = "key_pair"   

    connection {
      host = aws_instance.web-private.private_ip
      user = "ec2-user"
      private_key = file("key_pair.pem")

      bastion_host = aws_instance.web-public.public_ip
      bastion_user = "ec2-user"
      bastion_private_key = file("key_pair.pem")
    }

    # provisioner "remote-exec" {
    #     inline = [
    #         "sudo yum remove -y java",
    #         "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo",
    #         "sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key",
    #         "sudo yum install -y jenkins java-1.8.0-openjdk git",
    #         "sudo service jenkins start"
    #     ]
    # }    
}
