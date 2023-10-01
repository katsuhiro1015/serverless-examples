module "build" {
  source                    = "./modules/build"
  pjname                    = var.pjname
  github_repository         = var.github_repository
  branch                    = var.branch
  artifact_id               = module.s3.artifact_id
  aws_iam_role_build_arn    = module.iam.build_arn
  aws_iam_role_pipeline_arn = module.iam.pipeline_arn
}

module "iam" {
  source = "./modules/iam"
  pjname = var.pjname
  region = var.region
}

module "s3" {
  source = "./modules/s3"
  pjname = var.pjname
}
