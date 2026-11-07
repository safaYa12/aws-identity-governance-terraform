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

variable "invalid_employee_ids" {
  description = "Employee records that failed validation"
  type        = list(string)
}