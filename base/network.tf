resource "aws_vpc" "Kyrylo_Dobrosol_01_vpc" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    
    tags = {
      Name = "${local.owner}_01_vpc"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_a" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "${local.aws_region}a"

    tags = {
        Name = "${local.owner}_01_subnet_public_a"
        Terraform = local.terraform_flag
        Project = local.project_name
        Owner = local.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_b" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "${local.aws_region}b"

    tags = {
        Name = "${local.owner}_01_subnet_public_b"
        Terraform = local.terraform_flag
        Project = local.project_name
        Owner = local.owner
    }
}

resource "aws_subnet" "Kyrylo_Dobrosol_01_subnet_public_c" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "${local.aws_region}c"

    tags = {
        Name = "${local.owner}_01_subnet_public_c"
        Terraform = local.terraform_flag
        Project = local.project_name
        Owner = local.owner
    }
}

resource "aws_internet_gateway" "Kyrylo_Dobrosol_01_igw" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
    
    tags = {
      Name = "${local.owner}_01_igw"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}

resource "aws_route_table" "Kyrylo_Dobrosol_01_rt" {
    vpc_id = aws_vpc.Kyrylo_Dobrosol_01_vpc.id

    tags = {
      Name = "${local.owner}_01_rt"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}