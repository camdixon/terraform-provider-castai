variable "castai_api_token" {
  type        = string
  description = "CAST.AI api token"
}

variable "aws_access_key_id" {
  type        = string
  description = "Your own access key id for operating terraform"
}

variable "aws_secret_access_key" {
  type        = string
  description = "Your own access key secret for operating terraform"
}

variable "cluster_region" {
  type        = string
  description = "AWS region your cluster is located."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name in AWS account."
}

variable "subnets" {
  type        = list(string)
  description = "Optional custom subnets for the cluster. If not set subnets from the EKS cluster configuration are used."
  default     = []
}

variable "security_groups" {
  type        = list(string)
  description = "Optional custom security groups for the cluster. If not set security groups from the EKS cluster configuration are used."
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "Optional tags for new cluster nodes. This parameter applies only to new nodes - tags for old nodes are not reconciled."
  default     = {}
}

variable "delete_nodes_on_disconnect" {
  type        = bool
  description = "Optional parameter, if set to true - CAST AI provisioned nodes will be deleted from EC2 on cluster disconnection."
  default     = false
}

variable "eks_user_role_arn" {
  type = string
  description = "Optional role arn that should be added to aws-auth Configmap for users that should have access to EKS cluster. More info: https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html"

  default = null
}

variable "loki_bucket_name" {
  type = string
}