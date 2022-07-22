# data sources can be used to do something and then give you data 
# data sources will just provide you information 
# the code below will get the most recent ami that has the name prefix app-

# data "aws_ami" "app_ami" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["app-*"]
#   }
# }

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_iam_policy" "eks_worker_node" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "eks_cni_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "ecr_read_only" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "ssm_managed_instance" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "fluentbit-es-policy" {
  name        = "fluentbit-es-policy"
  path        = "/"
  /* description = "My test policy" */

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
      Version = "2012-10-17"
      "Statement": [
    {
      "Action": [
        "es:ESHttp*"
      ],
      "Resource": "arn:aws:es:${var.aws_region}:${var.account_id}:domain/${var.es_domain}",
      "Effect": "Allow"
    }
  ]
  })
}

