locals {
  access_assignments = {
    engineering_development = {
      department     = "engineering"
      account        = "development"
      permission_set = "engineering"
    }

    sales_development = {
      department     = "sales"
      account        = "development"
      permission_set = "sales"
    }

    finance_development = {
      department     = "finance"
      account        = "development"
      permission_set = "finance"
    }

    hr_development = {
      department     = "hr"
      account        = "development"
      permission_set = "hr"
    }

    education_development = {
      department     = "education"
      account        = "development"
      permission_set = "education"
    }
  }
}
resource "aws_ssoadmin_account_assignment" "department_access" {

  for_each = local.access_assignments

  instance_arn = var.instance_arn

  permission_set_arn = var.permission_sets[
    each.value.permission_set
  ].arn

  principal_id = var.groups[
    each.value.department
  ].group_id

  principal_type = "GROUP"

  target_id = var.aws_accounts[
    each.value.account
  ]

  target_type = "AWS_ACCOUNT"
}