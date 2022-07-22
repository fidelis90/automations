resource "kubernetes_daemonset" "dev-eks-fluentbit" {
  metadata {
    name      = local.fluentbit-role-name
    namespace = kubernetes_namespace.dev-eks-fluentbit-ns.metadata.0.name

    labels = local.labels
  }

  spec {
    selector {
      match_labels = {
        k8s-app = local.labels.k8s-app
      }
    }

    template {
      metadata {
        labels = local.labels
      }

      spec {
        volume {
          name = "varlog"

          host_path {
            path = "/var/log"
          }
        }

        volume {
          name = "varlibdockercontainers"

          host_path {
            path = "/var/lib/docker/containers"
          }
        }

        volume {
          name = "fluent-bit-config"

          config_map {
            name = local.fluentbit-role-name
          }
        }

        container {
          name  = local.fluentbit-role-name
          image = "amazon/aws-for-fluent-bit:2.5.0"
          image_pull_policy =  "Always"

          port {
            container_port = 2020
          }

          dynamic "env" {
            for_each = local.env_variables
            content {
              name  = env.key
              value = env.value
            }
          }

          resources {
            limits = {
              memory = "100Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }

          volume_mount {
            name       = "varlog"
            mount_path = "/var/log"
          }

          volume_mount {
            name       = "varlibdockercontainers"
            read_only  = true
            mount_path = "/var/lib/docker/containers"
          }

          volume_mount {
            name       = "fluent-bit-config"
            mount_path = "/fluent-bit/etc/"
          }
        }

        termination_grace_period_seconds = 10
        service_account_name = kubernetes_service_account.dev-eks-fluentbit.metadata.0.name
      }
    }
  }
}