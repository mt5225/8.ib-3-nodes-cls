module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "configsvr" {
  source      = "./modules/ob"
  namespace   = var.namespace
  ssh_keypair = var.ssh_keypair
  vpc         = module.networking.vpc
  sg          = module.networking.sg

}

module "obsvr" {
  source      = "./modules/ob"
  count       = var.num
  namespace   = var.namespace
  ssh_keypair = var.ssh_keypair
  vpc         = module.networking.vpc
  sg          = module.networking.sg

}

data "aws_instance" "obsvrs" {
  count       = var.num
  instance_id = module.obsvr[count.index].id
}

locals {
  private_ips = [for item in data.aws_instance.obsvrs : item.private_ip]
}

resource "ansible_host" "configsvr" {
  inventory_hostname = module.configsvr.public_ip
  groups             = ["configsvr"]
  vars = {
    ansible_user = "centos"
    ob_nodes     = "${join(",", local.private_ips)}"
  }
}
