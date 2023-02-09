module "vpc" {
  source                  = "../../vpc_module"
  vpc_cidr_block          = local.vpc_cidr
  ressource_identifer     = "tm-yf-env"
  tags                    = local.tags
  public_subnets          = local.public_subnets
  availability_zone_count = local.az_count
}

module "ec2" {
  source = "../../ec2_module"
  depends_on = [
    module.vpc
  ]
  tags               = local.tags
  vpc_id             = module.vpc.vpc_id
  subnet_id          = element(module.vpc.subnets, 0).id
  ami_id             = local.ami_id
  ec_type            = local.ec_type
  availability_zone  = element(module.vpc.subnets, 0).availability_zone
  private_ip         = local.private_ip
  nic_private_ips    = local.nic_private_ips
  identification_key = local.identification_key


}
