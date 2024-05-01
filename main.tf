provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dasa2024" {
    ami = "ami-0f75a13ad2e340a58"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg-demo.id]
    
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install httpd
                sudo systemctl enable httpd
                sudo systemctl start httpd
                echo "Hello World" > /var/www/html/index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

    tags = {
        Name = "dasa_practice"
    }    
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