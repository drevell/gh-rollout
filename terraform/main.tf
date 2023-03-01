module "cloudrun_cicd" {
  # TODO make these tfvars
  source          = "./modules/cloudrun-cicd-environments"
  billing_account = "009DE6-A7C95A-2AEE97"
  folder_id       = "436745444848"

  service_name                 = "my-hello-service"
  artifact_repository_location = "us-west1"

  github_owner_id        = 168090 # github.com/drevell
  github_repository_name = "gh-rollout"
  github_repository_id   = 594214686 # github.com/drevell/gh-rollout

  deployment_environments = [{
    environment_name = "dev"
    cloudrun_region  = "us-west1"
    }, {
    environment_name = "staging"
    cloudrun_region  = "us-west1"
    }, {
    environment_name = "prod"
    cloudrun_region  = "us-west1"
  }]
}

# TODO: expand scope to include creating github repo?
# resource "github_repository" "example" {
#   name        = "todo"
#   description = "todo"

#   visibility = "public"

#   template {
#     owner      = "foo"
#     repository = "bar"
#   }
# }
