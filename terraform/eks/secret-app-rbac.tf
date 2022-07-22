resource "kubernetes_namespace" "secret-app-ns" {
  metadata {
    name = var.secret_app_namespace
  }
}

resource "kubernetes_service_account" "secret-sa" {
  metadata {
    name = local.secret-sa-name
    namespace = kubernetes_namespace.secret-app-ns.metadata.0.name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role_csi_driver.iam_role_arn
    }
  }
}