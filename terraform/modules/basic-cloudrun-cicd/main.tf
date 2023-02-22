
resource "google_project" "worker_project" {
    for_each = var.environments
    name = "${var.proj_name_prefix} ${each.key}"
    project_id = "${var.proj_id_prefix}-${each.key}"
    folder_id = var.folder_id
    billing_account = var.billing_account
}

# # TODO comment
# module "github_ci_access_config" {
#     source = "github.com/abcxyz/terraform-modules/modules/github_ci_infra"
#     project_id = var.admin_project_id
#     github_owner_name = var.github_owner_name
#     github_repository_name = var.github_repository_name
#     name = var.service_name  # This is used as part of the CI service account name
# }
