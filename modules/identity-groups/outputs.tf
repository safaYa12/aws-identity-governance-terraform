output "department_groups" {
  description = "Created department groups"

  value = {
    for department, group in aws_identitystore_group.department_groups :

    department => {
      group_id = group.group_id
      name     = group.display_name
    }
  }
}

output "employee_memberships" {
  description = "Created employee group memberships"

  value = {
    for employee_id, membership in aws_identitystore_group_membership.employee_memberships :

    employee_id => membership.membership_id
  }
}