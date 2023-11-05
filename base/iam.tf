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
    name        = "${local.owner}_01_bucket_write_role_policy_${aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket}"
    path        = "/"
    description = "My test policy with write permission for epam-aws-tf-lab bucket only"
    
    policy = data.aws_iam_policy_document.bucket_write_role_policy.json

    tags = {
      Name = "${local.owner}_01_bucket_write_role_policy_${aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket}"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
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
    name = "${local.owner}_01_bucket_write_role"    
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    managed_policy_arns = [aws_iam_policy.Kyrylo_Dobrosol_01_bucket_write_role_policy.arn]
    
    tags = {
      Name = "${local.owner}_01_bucket_write_role"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}

resource "aws_iam_instance_profile" "Kyrylo_Dobrosol_01_instance_profile" {
    name = "${local.owner}_01_instance_profile"  
    role = aws_iam_role.Kyrylo_Dobrosol_01_bucket_write_role.name

    tags = {
      Name = "${local.owner}_01_instance_profile"  
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}