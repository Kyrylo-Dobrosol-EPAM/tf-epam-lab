resource "aws_launch_template" "Kyrylo_Dobrosol_01_launch_template" {
    name = "epam-aws-tf-lab"
    
    iam_instance_profile {
      name = local.base_outputs.iam_instance_profile_name
    }

    update_default_version = true    
    image_id = "ami-05c13eab67c5d8861"    
    instance_type = "t2.micro"
    
    vpc_security_group_ids = [local.base_outputs.security_group_id_http_lb]

    user_data = "${base64encode(data.template_file.init_script.rendered)}"
}

data "template_file" "init_script" {
    template = "${file("instance_script.tpl")}"
    vars = {
      bucket_name = "${local.base_outputs.s3_bucket_name}"
    }
}

resource "aws_autoscaling_group" "epam-aws-tf-lab-asg" {
    #availability_zones = ["${local.aws_region}a"]
    desired_capacity   = 1
    max_size           = 1
    min_size           = 1
    vpc_zone_identifier  = local.base_outputs.public_subnet_ids
    
    launch_template {
      id      = aws_launch_template.Kyrylo_Dobrosol_01_launch_template.id
      version = "$Latest"
    }

    lifecycle {
      ignore_changes = ["load_balancers", "target_group_arns"]
    }
}

resource "aws_lb" "epam-aws-tf-lab-lb" {
    name               = "epam-aws-tf-lab-lb"
    load_balancer_type = "application"
    security_groups    = [local.base_outputs.security_group_id_http_lb,local.base_outputs.security_group_id_ssh,local.base_outputs.security_group_id_http]
    subnets            = local.base_outputs.public_subnet_ids
    
    enable_deletion_protection = false
    internal = true

    tags = {
      Name = "${local.owner}_01_epam-aws-tf-lab-lb"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}

resource "aws_lb_target_group" "epam-aws-tf-lab-tg" {
  name     = "epam-aws-tf-lab-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.base_outputs.vpc_id
}

resource "aws_lb_listener" "epam-aws-tf-lab-l1" {
  load_balancer_arn = aws_lb.epam-aws-tf-lab-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.epam-aws-tf-lab-tg.arn
  }
}

resource "aws_autoscaling_attachment" "epam-aws-tf-lab-asa" {
    autoscaling_group_name = aws_autoscaling_group.epam-aws-tf-lab-asg.id
    lb_target_group_arn    = aws_lb_target_group.epam-aws-tf-lab-tg.arn
}