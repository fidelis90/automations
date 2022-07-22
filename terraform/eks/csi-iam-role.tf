module "iam_assumable_role_csi_driver" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  create_role                   = true
  role_name                     = "csi-driver-${var.cluster_name}"
  provider_url                  = module.eks.cluster_oidc_issuer_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.secret_app_namespace}:${local.secret-sa-name}"]
}

# Give the role the policy to what it needs. There is a GH issue (https://github.com/aws/karpenter/issues/507)
# that will better restrict this policy. This policy reflects the docs for this release.
resource "aws_iam_role_policy" "csi_read_access" {
  name = "csi-driver-policy-${var.cluster_name}"
  role = module.iam_assumable_role_csi_driver.iam_role_name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "*"
        }
    ]
})
}