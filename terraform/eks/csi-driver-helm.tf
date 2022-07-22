resource "helm_release" "secret_storage_csi_driver" {
  chart      = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  name       = "secrets-store-csi-driver"
  namespace  = local.kube_namespace
  version    = "1.0.1"
  atomic     = true

  set {
    name  = "linux.tolerations[0].operator"
    value = "Exists"
  }

  set {
    name  = "linux.tolerations[0].effect"
    value = "NoSchedule"
  }

  set {
    name  = "syncSecret.enabled"
    value = true
  }

  set {
    name  = "enableSecretRotation"
    value = true
  }
}
