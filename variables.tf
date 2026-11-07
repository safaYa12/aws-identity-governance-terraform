variable "aws_region" {
  description = "AWS region where IAM Identity Center is configured"
  type        = string
  default     = "us-east-1"

}
variable "allowed_departments" {
  description = "Approved employee departments"

  type = set(string)

  default = [
    "engineering",
    "finance",
    "hr",
    "sales",
    "education",
    "operations"
  ]
}

variable "allowed_roles" {
  description = "Approved employee job roles"

  type = set(string)

  default = [
    "MANAGER",
    "ANALYST",
    "HR_SPECIALIST",
    "FINANCE_MANAGER",
    "DEVELOPER"
  ]
}
variable "aws_accounts" {
  description = "AWS accounts available for Identity Center assignments"

  type = map(string)

  validation {
    condition = alltrue([
      for account_id in values(var.aws_accounts) :
      can(regex("^[0-9]{12}$", account_id))
    ])

    error_message = "Every AWS account ID must contain exactly 12 digits."
  }
}