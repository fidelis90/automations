//Null resource to run aws eks update config command

resource "null_resource" "kube-config-generator" {

  triggers = {
    eks_cluster_id = module.eks.cluster_id
  }

  provisioner "local-exec" {
    command = "aws eks --region us-east-1 update-kubeconfig --name dev-eks-cluster --profile ndx"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [module.eks]
}