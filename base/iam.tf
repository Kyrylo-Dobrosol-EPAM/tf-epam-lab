resource "aws_iam_group" "test-move" {
	name = "test-move"
}

data "aws_iam_policy_document" "bucket_write_role_policy" {
  statement {
    actions = ["s3:PutObject"]
    effect = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket}/*"]
  }
}

resource "aws_iam_policy" "Kyrylo_Dobrosol_01_bucket_write_role_policy" {
    name        = "${var.owner}_01_bucket_write_role_policy_${aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket}"
    path        = "/"
    description = "My test policy with write permission for epam-aws-tf-lab bucket only"
    
    policy = data.aws_iam_policy_document.bucket_write_role_policy.json

    tags = {
      Name = "${var.owner}_01_bucket_write_role_policy_${aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket}"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "Kyrylo_Dobrosol_01_bucket_write_role" {
    name = "${var.owner}_01_bucket_write_role"    
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    managed_policy_arns = [aws_iam_policy.Kyrylo_Dobrosol_01_bucket_write_role_policy.arn]
    
    tags = {
      Name = "${var.owner}_01_bucket_write_role"
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}

resource "aws_iam_instance_profile" "Kyrylo_Dobrosol_01_instance_profile" {
    name = "${var.owner}_01_instance_profile"  
    role = aws_iam_role.Kyrylo_Dobrosol_01_bucket_write_role.name

    tags = {
      Name = "${var.owner}_01_instance_profile"  
      Terraform = var.terraform_flag
      Project = var.project_name
      Owner = var.owner
    }
}