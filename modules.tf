module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  name_project = var.name_project
  tags         = local.tags
} 