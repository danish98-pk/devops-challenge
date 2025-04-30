#provider info
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# # Use S3 as backend for state
terraform {
  backend "s3" {
    bucket  = "crewmeister-devops-challenge"
    key     = "tfstatefile"
    region  = "us-east-1"
    profile = "default"
  }
}

