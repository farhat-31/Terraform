terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --- Key pair for SSH access (used by remote-exec) ---
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# --- Security group allowing SSH ---
resource "aws_security_group" "provisioner_demo_sg" {
  name        = "provisioner-demo-sg"
  description = "Allow SSH inbound"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- EC2 instance with provisioners ---
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.provisioner_demo_sg.id]

  tags = {
    Name = "provisioner-demo"
  }

  # 1. file provisioner: copy a local script to the remote instance
  provisioner "file" {
    source      = "${path.module}/scripts/setup.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  # 2. remote-exec provisioner: run commands on the remote instance
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh",
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  # 3. local-exec provisioner: run a command on the machine running Terraform
  provisioner "local-exec" {
    command = "echo \"Instance ${self.id} created with public IP ${self.public_ip}\" >> provisioned_hosts.txt"
  }

  # 4. destroy-time provisioner: runs when the resource is destroyed
  provisioner "local-exec" {
    when    = destroy
    command = "echo \"Instance ${self.id} destroyed\" >> provisioned_hosts.txt"
  }
}
