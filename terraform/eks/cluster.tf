## This is the module that configures the eks cluster 
## Contains the following 
## - The EKS Cluster Version 
#    - The EKS Terraform module 
#    - Details about the worker nodes( Instance type, root volume disk type and the security groups for the worker nodes )

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "<18"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.dev_eks_subnets 

  vpc_id = module.vpc.vpc_id

  cluster_iam_role_name = "${var.cluster_name}-role"
  cluster_create_security_group   = true
  cluster_create_timeout    =     "900s"
  enable_irsa   =   true 

  workers_additional_policies = [aws_iam_policy.ingress_worker_policy.arn, var.aws_s3_readonly_policy, var.aws_ssm_access_policy, var.aws_lambda_access, aws_iam_policy.fluentbit-es-policy.arn]

  node_groups  = {

    eks-workers-us-west-1a = {
      name                         = var.ng-us-west-1a
      desired_capacity             = 1
      min_capacity                 = 1
      max_capacity                 = 10
      key_name                     = var.keypair
      workers_role_name = "${var.cluster_name}-${var.ng-us-west-1a}"
      subnets                      = var.dev_eks_private_subnets_us_west_1a
      set_instance_types_on_lt     = true
      worker_create_security_group = true
      launch_template_id           = aws_launch_template.eks-workers.id
      launch_template_version      = aws_launch_template.eks-workers.default_version
    }

    eks-workers-us-west-1b = {
      name                         = var.ng-us-west-1b
      desired_capacity             = 1
      min_capacity                 = 1
      max_capacity                 = 10
      workers_role_name = "${var.cluster_name}-${var.ng-us-west-1b}"
      subnets                      = var.dev_eks_private_subnets_us_west_1b
      set_instance_types_on_lt     = true
      worker_create_security_group = true
      launch_template_id           = aws_launch_template.eks-workers.id
      launch_template_version      = aws_launch_template.eks-workers.default_version
      key_name                     = var.keypair
    }

    eks-workers-us-west-1c = {
      name                         = var.ng-us-west-1c
      desired_capacity             = 1
      min_capacity                 = 1
      max_capacity                 = 10
      workers_role_name = "${var.cluster_name}-${var.ng-us-west-1c}"
      subnets                      = var.dev_eks_private_subnets_us_west_1c
      set_instance_types_on_lt     = true
      worker_create_security_group = true
      launch_template_id           = aws_launch_template.eks-workers.id
      launch_template_version      = aws_launch_template.eks-workers.default_version
      key_name                     = var.keypair
    }
  }

  tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
  # map_roles = var.map_roles
  # map_users = var.map_users
  
}


