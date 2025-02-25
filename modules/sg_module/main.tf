resource "aws_security_group" "sg_allow_ssh_http_https_tcp8080" {
    name = var.sg_name

    ingress {
        description = "allow http" 
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = var.trust_IP
        
    }
    ingress {
        description = "allow https" 
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = var.trust_IP
        
    }
    ingress {
        description = "allow http 8080" 
        protocol = "tcp"
        from_port = 8080
        to_port = 8080
        cidr_blocks = var.trust_IP
        
    }
    ingress {
        description = "allow SSH " 
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = var.trust_IP
        
    }
    egress {
        description = "allow output" 
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        
    }
}