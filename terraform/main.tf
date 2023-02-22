locals {
    billing_account = "009DE6-A7C95A-2AEE97"
    folder_id = "436745444848"

    proj_name_prefix = "revell 03"
    proj_id_prefix = "revell-03"
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

module "hello-service" {
    source = "./modules/basic-cloudrun-cicd"
    folder_id = local.folder_id
    billing_account = local.billing_account
    admin_project_id = google_project.admin_project.project_id
    proj_name_prefix = "${local.proj_name_prefix} hello"
    proj_id_prefix = "${local.proj_id_prefix}-hello"

    service_name = "hello-service"
    github_owner_name = "drevell"
    github_repository_name = "gh-rollout"
    environments = {
        "dev": {
            region: "us-west1",
        }
        "staging": {
            region: "us-central1",
            # TODO: support automated tests in staging
        }
        "prod": {
            region: "us-west1",
        }
    }
}

module "bonjour-service" {
    source = "./modules/basic-cloudrun-cicd"
    folder_id = local.folder_id
    billing_account = local.billing_account
    admin_project_id = google_project.admin_project.project_id
    proj_name_prefix = "${local.proj_name_prefix} bonjour"
    proj_id_prefix = "${local.proj_id_prefix}-bonjour"

    service_name = "bonjour-service"
    github_owner_name = "drevell"
    github_repository_name = "gh-rollout"

    environments = {
        "dev": {
            region: "us-east1",
        }
        "staging": {
            region: "us-west1",
        }
        "prod": {
            region: "us-central1",
        }
    }
}


