module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  name_project = var.name_project
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  name_project     = var.name_project
  tags             = local.tags
  public_subnet_1a = module.eks_network.eks_subnet_public_1a
  public_subnet_1b = module.eks_network.eks_subnet_public_1b
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  name_project      = var.name_project
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.eks_subnet_private_1a
  subnet_private_1b = module.eks_network.eks_subnet_private_1b
  tags              = local.tags
}

module "eks_aws_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  name_project = var.name_project
  tags         = local.tags
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
}