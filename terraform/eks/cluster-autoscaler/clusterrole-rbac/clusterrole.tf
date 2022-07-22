/* resource "kubernetes_cluster_role" "autoscaler-cluster-role" {
  metadata {
    name = lower(var.autoscaler_cluster_role_name)
    labels = {
      var.label1 = var.label_value1 
    }
  }

  # for each item in the list of this variable map of rules. 
  
  dynamic "rule" {
    for_each = var.autoscaler_cluster_role_rules 

    content {
      api_groups = rule.value.api_groups
      resources = rule.value.resources 
      verbs = rule.value.verbs 
    }
  }
} */