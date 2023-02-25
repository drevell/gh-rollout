
resource "google_project" "project" {
    # for_each = var.environments
    # name = "${var.proj_name_prefix} ${each.key}"
    # project_id = "${var.proj_id_prefix}-${each.key}"
    
    # name = "${var.proj_name_prefix} ${var.environment}"
    # project_id = "${var.proj_id_prefix}-${each.key}"

    name = var.project_name
    project_id = var.project_id
    
    folder_id = var.folder_id
    billing_account = var.billing_account
}


resource "google_project_service" "default" {
    depends_on = [
      google_project.project
    ]
    for_each = toset([
        "iam.googleapis.com",
        "run.googleapis.com",
    ])
    service  = each.value
    project  = var.project_id
}

resource "google_service_account" "cloudrun_service_account" {
    depends_on = [google_project_service.default]
    account_id   = "${var.service_name}-${var.environment_name}-sa"
    display_name = "${var.service_name} ${var.environment_name} SA"
    project      = google_project.project.project_id
}
data "google_iam_policy" "impersonate" {
    binding {
        role = "roles/iam.serviceAccountUser"
        members = [
            "serviceAccount:${var.cicd_service_account_email}",
        ]
    }
}
resource "google_service_account_iam_policy" "impersonate" {
    service_account_id = google_service_account.cloudrun_service_account.name
    policy_data = data.google_iam_policy.impersonate.policy_data
}
resource "google_cloud_run_service" "default" {
    depends_on = [google_service_account.cloudrun_service_account]
    name = var.service_name
    location = var.cloudrun_region
    project = google_project.project.project_id

    template {
        spec {
            service_account_name = google_service_account.cloudrun_service_account.email
            containers {
                image = var.initial_container_image
            }
        }
    } 
}
data "google_iam_policy" "developer" {
    binding {
        role = "roles/run.developer"
        members = [
            "serviceAccount:${var.cicd_service_account_email}",
        ]
    }

    # TODO Likely this will be necessary for public HTTP, test it.
    # TODO add an input variable bool for "should be public".
    #   binding {
    #     role = "roles/run.invoker"
    #     members = [
    #       "allUsers",
    #     ]
    #   }

}
resource "google_cloud_run_service_iam_policy" "developer" {
    location = google_cloud_run_service.default.location
    project  = google_cloud_run_service.default.project
    service = google_cloud_run_service.default.name
    policy_data = data.google_iam_policy.developer.policy_data
}

resource "github_repository_environment" "default" {
    environment = var.environment_name
    repository = "${var.github_repository}"
    reviewers {
        users = var.reviewer_users
        teams = var.reviewer_teams
    }
    deployment_branch_policy {
        protected_branches = var.protected_branches
        custom_branch_policies = false
    }
}

