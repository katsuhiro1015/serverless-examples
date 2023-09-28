resource "aws_codepipeline" "example" {
  name     = "${pjname}-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["Source"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = var.github_repository
        BranchName           = var.branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  # Build, Deploy ステージの記述は省略
  # terraform apply 実行時には必須

  artifact_store {
    location = var.artifact_id
    type     = "S3"
  }
}
