locals {
    billing_account = "009DE6-A7C95A-2AEE97"
    folder_id = "436745444848"

    proj_name_prefix = "revell hello service 03"
    proj_id_prefix = "revell-hello-03"
}

resource "google_project" "admin_project" {
    name            = "${local.proj_name_prefix} admin"
    project_id      = "${local.proj_id_prefix}-admin"
    folder_id       = local.folder_id
    billing_account = local.billing_account
}

# Enable GCP APIs
module "enable_admin_project_services" {
    source = "./modules/admin_project_services"
    project_id = google_project.admin_project.project_id
}

resource "google_service_account" "cicd_service_account" {
  account_id   = "cicd-sa"
  display_name = "CICD SA"
  project      = google_project.admin_project.project_id
}

# module "hello-service" {
#     source = "./modules/basic-cloudrun-cicd"
#     folder_id = local.folder_id
#     billing_account = local.billing_account
#     admin_project_id = google_project.admin_project.project_id
#     proj_name_prefix = "${local.proj_name_prefix} hello"
#     proj_id_prefix = "${local.proj_id_prefix}-hello"

#     service_name = "hello-service"
#     github_owner_name = "drevell"
#     github_repository_name = "gh-rollout"
#     # environments = {
#     #     "dev": {
#     #         region: "us-west1",
#     #     }
#     #     "staging": {
#     #         region: "us-central1",
#     #         # TODO: support automated tests in staging
#     #     }
#     #     "prod": {
#     #         region: "us-west1",
#     #         # TODO: reviewers { }
#     #         # TODO: deployment_branch_policy { }
#     #     }
#     # }
# }

module dev_environment {
    folder_id = local.folder_id
    billing_account = local.billing_account
    source = "./modules/basic-cloudrun-cicd"
    project_name = "Hello dev"
    project_id = "revell-hello-dev"
    environment_name = "dev"
    cloudrun_region = "us-west1"
    service_name = "hello-service"
    cicd_service_account_email = google_service_account.cicd_service_account.email
    # TODO: reviewers { }
    # TODO: deployment_branch_policy { }
}
