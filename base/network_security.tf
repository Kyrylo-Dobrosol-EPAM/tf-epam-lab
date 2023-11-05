resource "aws_security_group" "ssh-inbound" {
    name        = "ssh-inbound"
    description = "allows ssh access from safe IP-range"
    vpc_id      = aws_vpc.Kyrylo_Dobrosol_01_vpc.id

    ingress {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.Kyrylo_Dobrosol_01_vpc.cidr_block]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name = "${var.owner}_ssh_inbound"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

resource "aws_security_group" "lb-http-inbound" {
    name        = "lb-http-inbound"
    description = "allows http access from safe IP-range to a LoadBalancer"
    vpc_id      = aws_vpc.Kyrylo_Dobrosol_01_vpc.id

    ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.Kyrylo_Dobrosol_01_vpc.cidr_block]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name = "${var.owner}_lb-http-inbound"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

resource "aws_security_group" "http-inbound" {
    name        = "http-inbound"
    description = "allows http access from LoadBalancer"
    vpc_id      = aws_vpc.Kyrylo_Dobrosol_01_vpc.id

    ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups = [aws_security_group.lb-http-inbound.id]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name = "${var.owner}_http-inbound"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}