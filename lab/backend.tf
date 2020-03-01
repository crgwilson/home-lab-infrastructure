terraform {
  backend "s3" {
    bucket               = "cwilson-terraform-backend"
    dynamodb_table       = "cwilson-terraform-backend"
    region               = "us-east-1"
    key                  = "lab.tfvars"
    workspace_key_prefix = "lab"
    encrypt              = true
  }

  required_version = ">=0.12"
}
