output "identity_center_instance_arn" {
  description = "IAM Identity Center instance ARN"

  value = tolist(
    data.aws_ssoadmin_instances.current.arns
  )[0]
}
output "identity_store_id" {
  description = "Identity Store ID"

  value = tolist(
    data.aws_ssoadmin_instances.current.identity_store_ids
  )[0]
}
output "total_employees" {
  description = "Total number of employees in CSV"

  value = length(local.employees)
}

output "active_employee_ids" {
  description = "List of active employee IDs"

  value = [
    for employee in values(local.employees) :

    employee.employee_id

    if employee.employment_status == "ACTIVE"
  ]
}

output "invalid_employee_ids" {
  description = "Employee IDs containing invalid data"

  value = local.invalid_employee_ids
}

output "department_employee_mapping" {
  description = "Employees grouped by department"

  value = {

    for employee in values(local.employees) :

    employee.department => employee.employee_id...

  }
}
output "department_groups" {
  description = "Department groups created in Identity Center"

  value = module.identity_groups.department_groups
}

output "employee_memberships" {
  description = "Employee group membership IDs"

  value = module.identity_groups.employee_memberships
}
output "permission_sets" {
  description = "Enterprise department permission sets"

  value = module.permission_sets.permission_sets
}
output "account_assignments" {
  description = "AWS account access assignments"

  value = module.account_assignments.account_assignments
}