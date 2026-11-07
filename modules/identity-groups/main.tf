locals {
  departments = toset([
    for employee in values(var.employees) :
    employee.department
  ])
}

resource "aws_identitystore_group" "department_groups" {

  for_each = local.departments

  identity_store_id = var.identity_store_id

  display_name = "${title(each.value)}-Users"

  description = "Department access group for ${title(each.value)}"
}
resource "aws_identitystore_group_membership" "employee_memberships" {

  for_each = var.employees

  identity_store_id = var.identity_store_id

  group_id = aws_identitystore_group.department_groups[
    each.value.department
  ].group_id

  member_id = var.users[each.key].user_id
}
