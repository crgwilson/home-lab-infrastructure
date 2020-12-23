terraform {
  backend "remote" {
    organization = "crgwilson-personal-projects"

    workspaces {
      name = "projects"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.22.0"
    }
  }
}
