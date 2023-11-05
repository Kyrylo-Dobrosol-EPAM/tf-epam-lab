locals{
    aws_region = "us-east-1"
    terraform_flag = true
    project_name = "epam-tf-lab"
    owner = "Kyrylo_Dobrosol"
    base_outputs = data.terraform_remote_state.base.outputs
}