provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dasa2024" {
    ami = "ami-0f75a13ad2e340a58"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

    tags = {
        Name = "dasa_practice"
    }    
}

resource "aws_security_group" "instance" {
    name = "terraform_practice_sg"
  
    ingress {
        from_port = 0
        to_port = 0
        protocol = "All"
        cidr_blocks = ["0.0.0.0/0"]
    }

}