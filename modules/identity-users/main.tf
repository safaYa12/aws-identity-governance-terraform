resource "terraform_data" "validate_employees" {

  lifecycle {
    precondition {
      condition = length(var.invalid_employee_ids) == 0

      error_message = "Invalid employee records detected. User provisioning blocked."
    }
  }
}

resource "aws_identitystore_user" "employees" {

  for_each = var.employees

  identity_store_id = var.identity_store_id

  user_name = each.value.email

  display_name = join(" ", [
    each.value.first_name,
    each.value.last_name
  ])

  name {
    given_name  = each.value.first_name
    family_name = each.value.last_name
  }

  emails {
    value   = each.value.email
    primary = true
    type    = "work"
  }

  depends_on = [
    terraform_data.validate_employees
  ]
}