# TODO dashes to underscores throughout

module "cloudrun_cicd" {
  source = "./modules/cloudrun-cicd-environments"

  billing_account        = "009DE6-A7C95A-2AEE97"
  folder_id              = "436745444848"
  github_owner_id        = 168090 # github.com/drevell
  github_repository_name = "gh-rollout"
  github_repository_id   = 594214686 # github.com/drevell/gh-rollout

  service_name                 = "my-hello-service"
  artifact_repository_location = "us-west1"

  deployment_environments = [
    {
      environment_name = "dev"
      cloudrun_region  = "us-west1"
      environment_type = "non-prod"
    },
    {
      environment_name = "staging"
      cloudrun_region  = "us-west1"
      environment_type = "non-prod"
    },
    {
      environment_name         = "prod"
      cloudrun_region          = "us-west1"
      environment_type         = "prod"
      reviewer_user_github_ids = [168090]  # drevell
      reviewer_team_github_ids = [7454159] # abcxyz/infrastructure-team
    },
  ]
}
