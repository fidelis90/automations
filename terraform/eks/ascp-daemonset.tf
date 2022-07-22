resource "kubernetes_daemonset" "csi_secrets_store_provider_aws" {
  metadata {
    name      = "csi-secrets-store-provider-aws"
    namespace = local.kube_namespace
    labels = {
      app = "csi-secrets-store-provider-aws"
    }
  }
  spec {
    strategy {
      rolling_update {}
    }
    selector {
      match_labels = {
        app = "csi-secrets-store-provider-aws"
      }
    }
    template {
      metadata {
        labels = {
          app = "csi-secrets-store-provider-aws"
        }
        annotations = {}
      }
      spec {
        service_account_name = kubernetes_service_account.csi_secrets_store_provider_aws.metadata[0].name
        host_network         = true
        container {
          name              = "provider-aws-installer"
          image             = "public.ecr.aws/aws-secrets-manager/secrets-store-csi-driver-provider-aws:1.0.r2-2021.08.13.20.34-linux-amd64"
          image_pull_policy = "Always"
          args = [
            "--provider-volume=/etc/kubernetes/secrets-store-csi-providers"
          ]
          resources {
            requests = {
              cpu    = "50m"
              memory = "100Mi"
            }
            limits = {
              cpu    = "50m"
              memory = "100Mi"
            }
          }
          volume_mount {
            mount_path = "etc/kubernetes/secrets-store-csi-providers"
            name       = "providervol"
          }
          volume_mount {
            mount_path        = "/var/lib/kubelet/pods"
            mount_propagation = "HostToContainer"
            name              = "mountpoint-dir"
          }
        }
        volume {
          name = "providervol"
          host_path {
            path = "/etc/kubernetes/secrets-store-csi-providers"
          }
        }
        volume {
          name = "mountpoint-dir"
          host_path {
            path = "/var/lib/kubelet/pods"
            type = "DirectoryOrCreate"
          }
        }
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
        toleration {
          operator = "Exists"
          effect   = "NoSchedule"
        }
      }
    }
  }
}