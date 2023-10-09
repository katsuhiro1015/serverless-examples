module "build" {
  source                    = "./modules/build"
  pjname                    = var.pjname
  github_repository         = var.github_repository
  branch                    = var.branch
  artifact_id               = module.s3.artifact_id
  artifact_bucket           = module.s3.artifact_bucket
  aws_iam_role_build_arn    = module.iam.build_arn
  aws_iam_role_pipeline_arn = module.iam.pipeline_arn
}

module "iam" {
  source       = "./modules/iam"
  pjname       = var.pjname
  region       = var.region
  artifact_arn = module.s3.artifact_bucket
}

module "s3" {
  source = "./modules/s3"
  pjname = var.pjname
}

module "ecr" {
  source = "./modules/ecr"
  pjname = var.pjname
}