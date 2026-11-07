variable "instance_arn" {
  description = "IAM Identity Center instance ARN"
  type        = string
}

variable "session_duration" {
  description = "Maximum AWS account session duration"
  type        = string
  default     = "PT1H"
}