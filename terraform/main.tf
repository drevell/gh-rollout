locals {
    billing_account = "009DE6-A7C95A-2AEE97"
    folder_id = "436745444848"

    proj_name_prefix = "revell hello service 03"
    proj_id_prefix = "revell-hello-03"

    github_owner_name = "drevell"
    github_repository_name = "gh-rollout"
    github_owner_id = 168090 # github.com/drevell
    github_full_repo_name = "${local.github_owner_name}/${local.github_repository_name}"
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

# resource "google_service_account" "cicd" {
#   account_id   = "cicd-sa"
#   display_name = "CICD SA"
#   project      = google_project.admin_project.project_id
# }

# TODO comment
module "github_ci_access_config" {
#     source = "github.com/abcxyz/terraform-modules/modules/github_ci_infra"
    source = "/usr/local/google/home/revell/git/terraform-modules/modules/github_ci_infra" # locally hacked
    project_id = google_project.admin_project.project_id
    github_owner_name = local.github_owner_name
    github_repository_name = local.github_repository_name
    github_owner_id = local.github_owner_id
    name = "hello"
}

resource "github_actions_secret" "wif_provider" {
    repository = local.github_full_repo_name
    secret_name = "wif_provider"
    plaintext_value = module.github_ci_access_config.wif_provider_name
}

resource "github_actions_secret" "wif_service_account" {
    repository = local.github_full_repo_name
    secret_name = "wif_service_account"
    plaintext_value = module.github_ci_access_config.service_account_email
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
    cicd_service_account_email = module.github_ci_access_config.service_account_email
    github_repository = local.github_full_repo_name
    source = "./modules/cloudrun-cicd-environment"
    project_name = "Hello dev"
    project_id = "revell-hello-dev"
    environment_name = "dev"
    cloudrun_region = "us-west1"
    service_name = "hello-service"
}

module staging_environment {
    folder_id = local.folder_id
    billing_account = local.billing_account
    cicd_service_account_email = module.github_ci_access_config.service_account_email
    github_repository = local.github_full_repo_name
    source = "./modules/cloudrun-cicd-environment"
    project_name = "Hello staging"
    project_id = "revell-hello-staging"
    environment_name = "staging"
    cloudrun_region = "us-west1"
    service_name = "hello-service"
}

module prod_environment {
    folder_id = local.folder_id
    billing_account = local.billing_account
    cicd_service_account_email = module.github_ci_access_config.service_account_email
    github_repository = local.github_full_repo_name
    source = "./modules/cloudrun-cicd-environment"
    project_name = "Hello prod"
    project_id = "revell-hello-prod"
    environment_name = "prod"
    cloudrun_region = "us-west1"
    service_name = "hello-service"
    reviewer_users = [local.github_owner_id]
    protected_branches = true
    # TODO: deployment_branch_policy { }
}
