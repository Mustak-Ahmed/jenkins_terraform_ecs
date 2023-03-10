# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }

terraform {
  required_providers {
...
    rke = {
      source  = "rancher/rke"
      version = "1.1.0"
    }
  }
...
}
# Configure and downloading plugins for aws
provider "aws" {
  region     = "${var.aws_region}"
}
