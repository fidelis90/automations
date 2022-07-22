/* resource "kubernetes_role_binding" "autoscaler_rolebinding" {
  metadata {
    name = lower(var.autoscaler_rolebinding_name)
    labels = {
      var.label1 = var.label-value1
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "Role"
    name      = var.autoscaler_role_name
  }

  subject {
    kind = "ServiceAccount"
    name = var.cluster_autoscaler_service_account_name
    namespace = var.cluster_autoscaler_namespace
  }
} */
