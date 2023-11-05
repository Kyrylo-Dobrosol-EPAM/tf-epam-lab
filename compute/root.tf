terraform {
}

provider "aws" {
  region                  = "${local.aws_region}"
  shared_credentials_files = ["~/.aws/credentials"]
}