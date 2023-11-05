resource "aws_s3_bucket" "Kyrylo_Dobrosol_01_bucket" {
    bucket = "epam-aws-tf-lab-${random_string.my_numbers.result}"

    tags = {
      Name = "${local.owner}_01_bucket"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}