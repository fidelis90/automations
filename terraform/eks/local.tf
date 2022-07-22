locals {
  fluentbit-role-name = "dev-eks-fluentbit"

  secret-sa-name = "get-secret"

  kube_namespace = "kube-system"

  labels = {
    k8s-app = "dev-eks-fluentbit"
    version = "v1"
    "kubernetes.io/cluster-service" = "true"
  }

  env_variables = {
    "ES_HOST" : var.dev-eks-es-host,
    "ES_PORT" : var.dev-eks-es-port,
    "AWS_REGION" : var.aws_region,
    "ES_LOGSTASH_PREFIX" : "dev-eks-fluentbit"
  }
}