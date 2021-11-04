module "iam_instance_profile" {
  source  = "../aws-base/terraform-aws-iip"
  actions = ["logs:*", "rds:*"]
}

data "cloudinit_config" "config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloud_config.yaml")
  }
}

module "ob" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "3.2.0"
  name                        = "${var.namespace}-ec2"
  ami                         = data.aws_ami.centos.id
  instance_type               = var.instance_type
  key_name                    = var.ssh_keypair
  vpc_security_group_ids      = [var.sg]
  subnet_id                   = var.subnet
  iam_instance_profile        = module.iam_instance_profile.name
  associate_public_ip_address = var.public_ip
  user_data                   = data.cloudinit_config.config.rendered

  tags = {
    Terraform   = "true"
    Environment = "demo"
  }
}

