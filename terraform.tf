variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_region_az" {}
variable "aws_subnet_id" {}
variable "aws_sg_id" {}
variable "aws_instance_name" {}
variable "aws_key_name" {}
variable "aws_source_ami" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "weblogic" {
  ami = "${var.aws_source_ami}"
  instance_type = "t2.micro"
  source_dest_check = false
  key_name = "${var.aws_key_name}"
  availability_zone = "${var.aws_region_az}"
  vpc_security_group_ids = ["${var.aws_sg_id}"]
  subnet_id = "${var.aws_subnet_id}"
  associate_public_ip_address=false

  tags {
    Name = "${var.aws_instance_name}"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(replace("/home/ec2-user/.ssh/KEY_NAME.pem", "KEY_NAME", var.aws_key_name))}"
  }

  provisioner "file" {
    source      = "./ansible"
    destination = "/home/ec2-user/ansible"
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook -i 'localhost,' -c local /home/ec2-user/ansible/playbooks/main.yml"
    ]
  }

}
