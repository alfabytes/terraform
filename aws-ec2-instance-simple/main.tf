#######################################
######### EC2 INSTANCE SIMPLE #########
#######################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

locals {
  web_user_data = <<-EOF
              #! /bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2.service
              systemctl enable apache2.service
              echo "Hello from WEB - $(hostname -f)" > /var/www/html/index.html
              EOF
}

module "webserver" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-webserver"

  # ami                    = data.aws_ami.amazon_linux.id
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = var.instance_type
  key_name               = module.key_pair_web.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [ module.web_sg.security_group_id ]
  availability_zone      = element(module.vpc.azs, 1)
  subnet_id              = element(module.vpc.public_subnets, 1)

  associate_public_ip_address = true

  user_data = local.web_user_data

  tags = var.tags
}
