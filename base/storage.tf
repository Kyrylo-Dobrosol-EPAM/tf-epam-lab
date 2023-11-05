resource "aws_s3_bucket" "Kyrylo_Dobrosol_01_bucket" {
    bucket = "epam-aws-tf-lab-${random_string.my_numbers.result}"

    tags = {
      Name = "${var.owner}_01_bucket"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}