variable "instance_arn" {
  description = "IAM Identity Center instance ARN"
  type        = string
}

variable "aws_accounts" {
  description = "AWS account IDs"
  type        = map(string)
}

variable "groups" {
  description = "Department group IDs"
  type = map(object({
    group_id = string
    name     = string
  }))
}

variable "permission_sets" {
  description = "Department permission set ARNs"
  type = map(object({
    name = string
    arn  = string
  }))
}