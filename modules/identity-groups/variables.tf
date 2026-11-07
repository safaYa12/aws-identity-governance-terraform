variable "identity_store_id" {
  description = "AWS Identity Store ID"
  type        = string
}

variable "employees" {
  description = "Active employee records"

  type = map(object({
    employee_id       = string
    first_name        = string
    last_name         = string
    email             = string
    department        = string
    role              = string
    employment_status = string
  }))
}

variable "users" {
  description = "Provisioned Identity Center users"

  type = map(object({
    user_id  = string
    username = string
  }))
}
