terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.TF_VAR_AWS_ACCESS_KEY_ID
  secret_key = var.TF_VAR_AWS_SECRET_ACCESS_KEY
}

resource "aws_security_group" "my_sec_group" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "accept ssh rule"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outgoing"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    "Name" = "${var.ID}-Microservice"
  }
}

resource "aws_instance" "TestInstance" {
  ami                         = "ami-052efd3df9dad4825"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my_sec_group.id]
  associate_public_ip_address = true
  key_name                    = "eks"
  tags = {
    "Name" = "${var.ID}-Microservice"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ~/project/.circleci/ansible/inventory.txt"
  }
}
