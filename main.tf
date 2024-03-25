provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dasa123" {
    ami = "ami-00e87074e52e6c9f9"
    instance_type = "t2.micro"
}