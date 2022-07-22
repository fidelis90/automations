resource "kubernetes_service_account" "dev-eks-fluentbit" {
  metadata {
    name = local.fluentbit-role-name
    namespace = kubernetes_namespace.dev-eks-fluentbit-ns.metadata.0.name
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.fluentbit-role.arn
    }
  }
}

resource "kubernetes_cluster_role" "dev-eks-fluentbit" {
  metadata {
    name = local.fluentbit-role-name
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods"]
    verbs      = ["get", "list", "watch"]
  }
}




resource "kubernetes_cluster_role_binding" "dev-eks-fluentbit" {
  metadata {
    name = local.fluentbit-role-name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.fluentbit-role-name
  }
  subject {
    kind      = "ServiceAccount"
    name      = local.fluentbit-role-name
    namespace = kubernetes_namespace.dev-eks-fluentbit-ns.metadata.0.name
  }
}