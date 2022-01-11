terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}


provider "aws" {
 
 region = var.region
 access_key= var.access_key
 secret_key= var.secret_key
 
}


resource "aws_key_pair" "deployer" {
    key_name   = var.key_pair_name
    public_key = var.key_pair_public_key 
}

data "template_file" "user_data" {
  template = file(var.user_data)
}

data "aws_vpc" "main" {
 id = var.own_vpc
}

resource "aws_security_group" "sg_my_server" {
  name        =  var.security_group_name
  description = var.security_group_description
  vpc_id      = "${data.aws_vpc.main.id}"

  ingress  {
            description      = "HTTP"
            from_port        = 80
            to_port          = 80
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            }
   ingress  {
            description      = "SSH"
            from_port        = 22
            to_port          = 22
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            }
  
  egress {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
         }

}


resource "aws_instance" "my_server"{
  ami = var.ami_id
  instance_type= var.instance_type_def
  key_name = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data = data.template_file.user_data.template
  tags = {
     Name = "MyServer"
     birthdate = timestamp()
   } 

}