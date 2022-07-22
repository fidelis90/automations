/* resource "kubernetes_role" "autoscaler-role" {
  metadata {
    name = lower(var.autoscaler_role_name)
    namespace = var.cluster_autoscaler_namespace
    labels = {
      var.label1 = var.label_value1
    }
  }

  dynamic "rule" {
    for_each = var.autoscaler_role_rules

    content {
      api_groups = rule.value.api_groups
      resources = rule.value.resources 
      verbs = rule.value.verbs 
    }
  }
} */