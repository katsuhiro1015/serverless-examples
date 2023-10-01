resource "aws_codepipeline" "pipeline_application" {
  name     = "${var.pjname}"
  role_arn = var.aws_iam_role_pipeline_arn

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = var.github_repository
        BranchName           = var.branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  # Build, Deploy ステージの記述は省略
  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]
      version = "1"

      configuration = {
        ProjectName = var.pjname
      }
    }
  }
  # terraform apply 実行時には必須

  artifact_store {
    location = var.artifact_id
    type     = "S3"
  }
}
