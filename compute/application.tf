resource "aws_launch_template" "Kyrylo_Dobrosol_01_launch_template" {
    name = "epam-aws-tf-lab"
    
    ebs_optimized = true
    
    iam_instance_profile {
      name = local.base_outputs.iam_instance_profile_name
    }

    update_default_version = true
    
    image_id = "ami-05c13eab67c5d8861"
    
    instance_type = "t2.micro"
    
    placement {
      availability_zone = "${local.aws_region}a"
    }

    network_interfaces {
        associate_public_ip_address = true
        security_groups = [local.base_outputs.security_group_id_ssh, local.base_outputs.security_group_id_http]
    }
    
    #vpc_security_group_ids = [local.base_outputs.security_group_id_ssh, local.base_outputs.security_group_id_http]

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
}

resource "aws_lb" "epam-aws-tf-lab-lb" {
    name               = "epam-aws-tf-lab-lb"
    load_balancer_type = "application"
    security_groups    = [local.base_outputs.security_group_id_http_lb]
    subnets            = local.base_outputs.public_subnet_ids
    
    enable_deletion_protection = true

    tags = {
      Name = "${local.owner}_01_epam-aws-tf-lab-lb"
      Terraform = local.terraform_flag
      Project = local.project_name
      Owner = local.owner
    }
}

resource "aws_autoscaling_attachment" "epam-aws-tf-lab-asa" {
    autoscaling_group_name = aws_autoscaling_group.epam-aws-tf-lab-asg.id
    elb                    = aws_lb.epam-aws-tf-lab-lb.id
}