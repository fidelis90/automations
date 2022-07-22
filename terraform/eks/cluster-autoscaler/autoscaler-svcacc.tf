/* resource "kubernetes_service_account" "cluster-autoscaler-svc-account" {
    metadata {
      name = var.cluster_autoscaler_service_account_name
      namespace = var.cluster_autoscaler_namespace

      labels = {
        var.label1 = var.label_value1
      }
    }
}

data "kubernetes_secret" "service-account-secret" {
    metadata {
      name = kubernetes_service_account.cluster-autoscaler-svc-account.default_secret_name
      namespace = var.cluster_autoscaler_namespace
    }
} */