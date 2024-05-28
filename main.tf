provider "aws" {
  region = "us-east-1"
}

variable "tcp_port" {
    description = "Used to open port"
    type = number
    default = 8080
}

resource "aws_security_group" "sg-demo" {
    name = "terraform_practice_sg"
  
    ingress {
        from_port = var.tcp_port
        to_port = var.tcp_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "dasa2024" {
    ami = "ami-0f75a13ad2e340a58"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.sg-demo.id ]


    user_data = <<-EOF
                #!/bin/bash
                echo "*** Installing apache2"
                sudo apt update -y
                sudo apt install apache2 -y
                echo "*** Completed Installing apache2"
                EOF
    
    # user_data = <<-EOF
    #             #!/bin/bash
    #             echo "Hello World" > index.html
    #             nohup busybox httpd -f ${var.tcp_port}  &
    #             EOF

}    

# resource "aws_autoscaling_group" "dasa-asg" {
#     launch_configuration = aws_launch_configuration.dasa2024.name
#     min_size = 2
#     max_size = 6
#     tag {
#       key = "Name"
#       value = "terraform as example"
#       propagate_at_launch = true
#     }






