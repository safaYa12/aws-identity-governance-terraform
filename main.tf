data "aws_ssoadmin_instances" "current" {}

module "identity_users" {

  source = "./modules/identity-users"

  identity_store_id = tolist(
    data.aws_ssoadmin_instances.current.identity_store_ids
  )[0]

  employees = local.active_employees

  invalid_employee_ids = local.invalid_employee_ids
}
module "identity_groups" {

  source = "./modules/identity-groups"

  identity_store_id = tolist(
    data.aws_ssoadmin_instances.current.identity_store_ids
  )[0]

  employees = local.active_employees

  users = module.identity_users.provisioned_users
}
module "permission_sets" {

  source = "./modules/permission-sets"

  instance_arn = tolist(
    data.aws_ssoadmin_instances.current.arns
  )[0]

  session_duration = "PT1H"
}
module "account_assignments" {

  source = "./modules/account-assignments"

  instance_arn = tolist(
    data.aws_ssoadmin_instances.current.arns
  )[0]

  aws_accounts = var.aws_accounts

  groups = module.identity_groups.department_groups

  permission_sets = module.permission_sets.permission_sets
}