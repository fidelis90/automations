# This is the module for creating the VPC for the eks cluster 
# The vpc resources are listed below 
# - vpc default region 
# - eks cluster name 
# - vpc az 
# - vpc subnets 
# - terraform aws vpc module 

# By default this module will provision new Elastic IPs for the Nat Gateways. when the VPC is destroyed those IPs are released. 
# It is handy to keep the same IPs even after the VPC is destroyed and recreated. To that end, it is possible to assign existing IPs to 
# the NAT gateways. This can be achieved by 

# resource "aws_eip" "nat" {
#   count = 3

#   vpc = true
# }


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name                 = "${var.cluster_name}-vpc"
  cidr                 = "10.220.16.0/24"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.220.16.64/26", "10.220.16.128/26", "10.220.16.192/26"]
  public_subnets       = ["10.220.16.0/28", "10.220.16.16/28", "10.220.16.32/28"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  reuse_nat_ips        = true
  external_nat_ip_ids  = aws_eip.nat.*.id
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    "karpenter.sh/discovery" = var.cluster_name
  }
}
