# Enables the necessary GCP services on the admin project.

locals {
  // The list of GCP APIs to enable
  admin_project_apis = [
    "iam.googleapis.com",
    "cloudbuild.googleapis.com",
    "clouddeploy.googleapis.com",
    "artifactregistry.googleapis.com",
    "compute.googleapis.com",
  ]
}

resource "google_project_service" "admin_enabled_services" {
  for_each = toset(local.admin_project_apis)
  service  = each.value
  project  = var.project_id
}