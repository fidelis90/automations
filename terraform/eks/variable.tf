variable "cluster_name" {
  default = "dev-eks-cluster"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_version" {
  default = "1.21"
}

variable "ebs_volume" {
  default = 20
}

variable "dev_eks_subnets" {
  default = ["subnet-02a0ca848ec846285", "subnet-07f18557a571b9638", "subnet-03557c0a05edb39e3", "subnet-0723b4f8993e0f11a", "subnet-09f3fa9ce7949a96b", "subnet-06536c2b4ebd96a55"]
}

variable "dev_eks_private_subnets" {
  default = ["subnet-02a0ca848ec846285", "subnet-07f18557a571b9638", "subnet-03557c0a05edb39e3"]
}

variable "dev_eks_public_subnets" {
  default = ["subnet-0723b4f8993e0f11a", "subnet-09f3fa9ce7949a96b", "subnet-06536c2b4ebd96a55"]
}

variable "dev_eks_private_subnets_us_west_1a" {
  type = set(string)
  default = ["subnet-02a0ca848ec846285"]
}

variable "dev_eks_private_subnets_us_west_1b" {
  type = set(string)
  default = ["subnet-07f18557a571b9638"]
}

variable "dev_eks_private_subnets_us_west_1c" {
  type = set(string)
  default = ["subnet-03557c0a05edb39e3"]
}

variable "dev_eks_public_subnets_us_west_1a" {
  type = set(string)
  default = ["subnet-0723b4f8993e0f11a"]
}

variable "dev_eks_public_subnets_us_west_1b" {
  type = set(string)
  default = ["subnet-09f3fa9ce7949a96b"]
}

variable "dev_eks_public_subnets_us_west_1c" {
  type = set(string)
  default = ["subnet-06536c2b4ebd96a55"]
}

variable "ng-us-west-1a" {
  default = "workers-us-west-1a"
}

variable "ng-us-west-1b" {
  default = "workers-us-west-1b"
}

variable "ng-us-west-1c" {
  default = "workers-us-west-1c"
}

variable "instance_type" {
  default = "r5.large"
}

variable "keypair" {
  default = "eks-ndx-key"
}

variable "enable_monitoring" {
  default = true
}

variable "aws_s3_readonly_policy" {
  default = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

variable "aws_ssm_access_policy" {
  default = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

variable "aws_lambda_access" {
  default = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

variable "profile" {
  default = "ndx"
}

variable "ingress_namespace" {
  default = "kube-system"
}

# Secrets-store and parameter store variables 

variable "secret_app_namespace" {
  default = "fidelis"
}

# Cluster autoscaler (KArpenter) variables 

variable "karpenter_namespace" {
  default = "karpenter"
}

# fluentbit logging variables 

variable "dev-eks-logging-ns" {
  default = "dev-eks-logging"
}

variable "dev-eks-es-host" {
  default = "search-dev-eks-4bmjxccddeuhjabo3dg7w5wpce.us-east-1.es.amazonaws.com"
}

variable "dev-eks-es-port" {
  default = 443
}

variable "logstash_prefix" {
  default = "dev-eks-fluentbit"
}

variable "es_domain" {
  default = "dev-eks"
}

variable "account_id" {
  default = "148302398499"
}

variable "map_users" {
  description = "Add the jenkins user to the aws-auth configmap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn-of-jenkins-user"
      username = "username of jenkins"
      groups   = ["system:masters"]
    }
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}
