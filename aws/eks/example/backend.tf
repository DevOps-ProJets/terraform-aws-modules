terraform {
  backend "s3" {
    bucket = "cars24-qa-tf-state"
    key    = "env/qa/eks/eks.tfstate"
    region = "ap-south-1"
  }
}