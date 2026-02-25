resource "aws_key_pair" "mykey" {
    key_name = "terra-key"
    public_key = file("~/.ssh/terra-key.pub")
}

resource "aws_default_vpc" "myvpc" {
    tags = {
        Name = "Default VPC"
    }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.myvpc.id #Interpolation is a way to use variables in terraform files

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "all traffic outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.aws_instance_type
    key_name = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    user_data = file("nginx.sh")
    instance_state = var.instance_state
    
    root_block_device {
        volume_size = var.root_volume_size
        volume_type = "gp3"
        delete_on_termination = true
    }

    tags = {
        Name = "Terraform EC2"
    }
}
