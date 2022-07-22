resource "kubernetes_service_account" "csi_secrets_store_provider_aws" {
  metadata {
    name      = "csi-secrets-store-provider-aws"
    namespace = local.kube_namespace
  }
}

resource "kubernetes_cluster_role" "csi_secrets_store_provider_aws" {
  metadata {
    name = "csi-secrets-store-provider-aws-cluster-role"
  }
  rule {
    api_groups = [""]
    resources  = ["serviceaccounts/token"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["serviceaccounts"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get"]
  }
}

resource "kubernetes_cluster_role_binding" "csi_secrets_store_provider_aws" {
  metadata {
    name = "csi-secrets-store-provider-aws-cluster-rolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.csi_secrets_store_provider_aws.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.csi_secrets_store_provider_aws.metadata[0].name
    namespace = kubernetes_service_account.csi_secrets_store_provider_aws.metadata[0].namespace
  }
}