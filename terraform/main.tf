data "aws_ami" "latest_ubuntu" {
  most_recent = true

  # Filter for the Ubuntu AMI
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # Canonical, the official Ubuntu image owner
  owners = ["099720109477"]
}
resource "aws_key_pair" "my_key" {
  key_name   = "my_ssh_key"
  public_key = file(var.ssh_public_key_path)
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http_8080"
  description = "SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to a more restrictive CIDR if necessary
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to a more restrictive CIDR if necessary
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch a t2.micro instance
resource "aws_instance" "my_instance" {
  ami             = data.aws_ami.latest_ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = {
    Name = "IRISIClubServer"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ../ansible/inventory/hosts.ini"
  }
  provisioner "local-exec" {
    command     = "sleep 40s && ansible-playbook -u ubuntu --private-key=~/.ssh/irisi  -i inventory/hosts.ini --limit webservers playbooks/setup-app-playbook.yml --diff"
    working_dir = "../ansible/"
  }
}