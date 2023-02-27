terraform {
  required_version = ">= 1.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18"
    }

    google = {
      version = ">= 4.45"
    }
  }
}