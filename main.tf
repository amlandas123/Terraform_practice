provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dasa2024" {
    ami = "ami-00e87074e52e6c9f9"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install -y httpd
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

resource "aws_security_group" "instance" {
    name = "terraform_practice_sg"
  
    ingress {
        from_port = All
        to_port = All
        protocol = "All"
        cidr_blocks = ["0.0.0.0/0"]
    }

}