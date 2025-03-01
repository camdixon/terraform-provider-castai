
data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.chunks.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.chunks.bucket}/*"
    ]
  }
  statement {
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_s3_bucket" "chunks" {
  bucket = var.loki_bucket_name
  acl    = "private"
  tags   = var.tags
  versioning {
    enabled = false
  }
}

module "eks_iam_role_s3" {
  source = "cloudposse/eks-iam-role/aws"

  tags        = var.tags

  aws_account_number          = data.aws_caller_identity.current.account_id
  eks_cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  service_account_name      = "loki"
  service_account_namespace = "tools"
  # JSON IAM policy document to assign to the service account role
  aws_iam_policy_document = [data.aws_iam_policy_document.this.json]

}

