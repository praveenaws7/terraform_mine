resource "aws_instance" "ha-httpd-node" {
  count                  = 3
  ami                    = "ami-00beae93a2d981137" # Change to your preferred AMI
  instance_type          = "t2.micro"
  key_name               = "haproxy"
  vpc_security_group_ids = ["sg-073a4723e357647d8"]

  tags = {
    Name = "httpd-node-${count.index + 1}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user" # Change this if you're using a different user
    private_key = file("/mnt/c/Users/QC/Downloads/haproxy.pem")
    host        = self.public_ip
  }

  # Provisioner to run script after instance creation
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd.service",
    ]
  }
}

# Execute fetch.sh immediately after EC2 instances are created
resource "null_resource" "execute_fetch_script" {
  triggers = {
    instance_ids = join(",", aws_instance.ha-httpd-node.*.id)
  }

  provisioner "local-exec" {
    command = "./fetch.sh"
    interpreter = ["/bin/bash", "-x"]  # Enable debug output
    environment = {
      TF_LOG = "DEBUG"  # Enable Terraform debug logs
    }
  }
}

resource "aws_instance" "ha-httpd-master" {
  ami                    = "ami-00beae93a2d981137" # Change to your preferred AMI
  instance_type          = "t2.micro"
  key_name               = "haproxy"
  vpc_security_group_ids = ["sg-073a4723e357647d8"]

  tags = {
    Name = "haproxy-master"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user" # Change this if you're using a different user
    private_key = file("/mnt/c/Users/QC/Downloads/haproxy.pem")
    host        = self.public_ip
  }

  # Provisioner to run script after instance creation
  provisioner "remote-exec" {
    inline = [
      "sudo yum install haproxy -y",
      "sudo systemctl start haproxy",
      "sudo chmod 777 /etc/haproxy/haproxy.cfg"
    ]
  }

  # Provisioner to upload the file
  provisioner "file" {
    source      = "/mnt/c/Users/QC/Desktop/Project_Terraform/terraform_mine/haproxy.cfg" # Change this to the local path of your file
    destination = "/etc/haproxy/haproxy.cfg"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl restart haproxy"
    ]
  }
}

output "public_ips" {
  value = aws_instance.ha-httpd-node.*.public_ip
  description = "The public IP addresses of the instances"
}
