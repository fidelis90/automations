resource "kubernetes_namespace" "dev-eks-fluentbit-ns" {
  metadata {
    name = var.dev-eks-logging-ns
  }
}