module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "configsvr" {
  source        = "./modules/ob"
  namespace     = var.namespace
  instance_type = "t3.small"
  ssh_keypair   = var.ssh_keypair
  subnet        = module.networking.vpc.public_subnets[0]
  sg            = module.networking.sg.proxy
  public_ip     = true
}

module "obsvr" {
  source        = "./modules/ob"
  count         = var.num
  namespace     = var.namespace
  instance_type = "t3.xlarge"
  ssh_keypair   = var.ssh_keypair
  subnet        = module.networking.vpc.database_subnets[0]
  sg            = module.networking.sg.db
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
