locals {
  tags = merge(var.tags, {
    created_by  = "terraform"
    created_for = "threat modeling simulation"
    desc        = "VPC for sumilation"
    env         = "dev"
  })

  vpc_cidr        = "10.12.3.0/24"
  az_count        = 1
  public_superset = cidrsubnet(local.vpc_cidr, 2, 0)
  public_subnets = [for index in range(local.az_count) :
    cidrsubnet(local.public_superset, 2, index)
  ]


  ami_id             = "ami-0ead712799090892e"
  ec_type            = "t2.micro"
  private_ip         = "10.12.3.50"
  nic_private_ips    = [local.private_ip]
  identification_key = ""
}
