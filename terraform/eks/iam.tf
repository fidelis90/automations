resource "aws_iam_policy" "ingress_worker_policy" {
  name        = "ingress_worker_policy"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}
