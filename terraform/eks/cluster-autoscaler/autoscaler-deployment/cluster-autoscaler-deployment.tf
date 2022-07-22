/* resource "kubernetes_deployment" "cluster-autoscaler" {
    metadata {
        name = var.cluster_autoscaler_name
        namespace = var.cluster_autoscaler_namespace
        labels = {
            "app" = var.cluster_autoscaler_label
        }
    }

    spec {
        replicas = 1
        selector {
          match_labels = {
              "app" = var.cluster_autoscaler_label
          }
        }

        template {
          metadata {
              labels = {
                  "app" = var.cluster_autoscaler_label
              }
              annotations = {
                "promotheus.io/port" = "8085"
                "promotheus.io/scrape" = "true"
              }
          }

          spec {
            automount_service_account_token  = true 
            termination_grace_period_seconds = 300
            service_account_name    = var.cluster_autoscaler_service_account_name
            container {
              image = var.image_name
              name = "cluster-autoscaler"
              command = ["./cluster-autoscaler",
                 "--v=4",
                 " --stderrthreshold=info",
                 "--cloud-provider=aws",
                 "--skip-nodes-with-local-storage=false",
                 "--expander=least-waste",
                 "--node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/${var.cluster_name}"
                ]
              resources {
                  limits {
                    cpu = "100m"
                    memory = "300Mi"
                  }
                  requests {
                    cpu = "100m"
                    memory = "300Mi" 
                  }
              }

              volume_mount {
                name = "ssl_certs"
                mount_path = "/etc/ssl/certs/ca-certificates.crt"
                read_only = "true"
              }
            }
            volume {
                name = "ssl-certs"
                host_path {
                  path = "/etc/ssl/certs/ca-bundle.crt"
                }
            }
          }
        }
    }
}
 */
