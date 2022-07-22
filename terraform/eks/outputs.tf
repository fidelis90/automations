output "cluster_endpoint" {
  description = "Endpoint for the EKS Control plane"
  value       = module.eks.cluster_endpoint
}

/* output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
} */

/* output "region" {
  description = "Region where the EKS Cluster is deployed"
  value       = var.aws_region
} */

