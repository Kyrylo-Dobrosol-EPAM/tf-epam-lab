resource "aws_vpc" "Kyrylo_Dobrosol_01_vpc" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    
    tags = {
      Name = "${var.owner}_01_vpc"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_a" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.aws_region}a"

    tags = {
        Name = "${var.owner}_01_subnet_public_a"
        Terraform = var.terraform_flag
        Project = var.project_name
        Owner = var.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_b" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "${var.aws_region}b"

    tags = {
        Name = "${var.owner}_01_subnet_public_b"
        Terraform = var.terraform_flag
        Project = var.project_name
        Owner = var.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_c" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "${var.aws_region}c"

    tags = {
        Name = "${var.owner}_01_subnet_public_c"
        Terraform = var.terraform_flag
        Project = var.project_name
        Owner = var.owner
    }
}

resource "aws_internet_gateway" "Kyrylo_Dobrosol_01_igw" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    
    tags = {
      Name = "${var.owner}_01_igw"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

resource "aws_route_table" "Kyrylo_Dobrosol_01_rt" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id

    tags = {
      Name = "${var.owner}_01_rt"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}