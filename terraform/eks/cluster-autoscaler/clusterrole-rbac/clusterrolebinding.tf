/* resource "kubernetes_cluster_role_binding" "autoscaler_clusterrolebinding" {
  metadata {
    name = lower(var.autoscaler_clusterrolebinding_name)
    labels = {
      var.label1 = var.label-value1
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name      = var.autoscaler_cluster_role_name
  }

  subject {
    kind = "ServiceAccount"
    name = var.cluster_autoscaler_service_account_name
    namespace = var.cluster_autoscaler_namespace
  }
} */